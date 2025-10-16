import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/commands/convert/helpers/annotation_extractor.dart';
import 'package:stacked_cli/src/commands/convert/helpers/field_extractor.dart';
import 'package:stacked_cli/src/commands/convert/helpers/method_extractor.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/posthog_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';

class ConvertViewCommand extends Command with ProjectStructureValidator {
  final _log = locator<ColorizedLogService>();
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _analyticsService = locator<PosthogService>();

  @override
  String get description =>
      'Converts an existing view to a responsive structure with mobile, tablet, and desktop variants.';

  @override
  String get name => 'view';

  ConvertViewCommand() {
    argParser
      ..addOption(
        ksDevice,
        abbr: 'd',
        allowed: ['mobile', 'tablet', 'desktop'],
        defaultsTo: 'mobile',
        help: kCommandHelpConvertViewDevice,
      )
      ..addOption(
        ksConfigPath,
        abbr: 'c',
        help: kCommandHelpConfigFilePath,
      )
      ..addOption(
        ksLineLength,
        abbr: 'l',
        help: kCommandHelpLineLength,
        valueHelp: '80',
      )
      ..addOption(
        ksProjectPath,
        help: kCommandHelpProjectPath,
      );
  }

  @override
  Future<void> run() async {
    try {
      final List<String> viewNames = argResults!.rest;

      if (viewNames.isEmpty) {
        _log.error(message: 'Please provide a view name to convert.');
        return;
      }

      final String targetDevice = argResults![ksDevice] as String;

      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: argResults![ksProjectPath],
      );

      _processService.formattingLineLength = argResults![ksLineLength];

      await _pubspecService.initialise(
        workingDirectory: argResults![ksProjectPath],
      );

      await validateStructure(outputPath: argResults![ksProjectPath]);

      // Check if responsive_builder is in dependencies and add it if missing
      final dependencies = _pubspecService.pubspecYaml.dependencies;
      if (!dependencies.any((dep) => dep.package() == 'responsive_builder')) {
        _log.info(
          message: 'Adding responsive_builder to pubspec.yaml dependencies...',
        );
        await _addResponsiveBuilderDependency(
          projectPath: argResults![ksProjectPath],
        );
      }

      // Track if we're converting multiple views
      final isMultipleViews = viewNames.length > 1;

      for (var viewName in viewNames) {
        await _convertViewToResponsive(
          viewName: viewName,
          targetDevice: targetDevice,
          projectPath: argResults![ksProjectPath],
          skipFormatting: isMultipleViews,
        );

        await _analyticsService.createViewEvent(
          name: viewName,
          arguments: argResults!.arguments,
        );
      }

      // If multiple views, format the entire views folder once at the end
      if (isMultipleViews) {
        final baseViewPath = _configService.viewPath;
        final fullViewPath = 'lib/$baseViewPath';
        final viewsPath = argResults![ksProjectPath] != null
            ? '${argResults![ksProjectPath]}/$fullViewPath'
            : fullViewPath;
        await _processService.runFormat(filePath: viewsPath);
      }
    } catch (e, s) {
      _log.error(message: e.toString());
      unawaited(_analyticsService.logExceptionEvent(
        runtimeType: e.runtimeType.toString(),
        message: e.toString(),
        stackTrace: s.toString(),
      ));
    }
  }

  Future<void> _addResponsiveBuilderDependency({
    String? projectPath,
  }) async {
    final pubspecPath =
        projectPath != null ? '$projectPath/pubspec.yaml' : 'pubspec.yaml';

    final pubspecContent =
        await _fileService.readFileAsString(filePath: pubspecPath);

    // Find the dependencies section and add responsive_builder
    final dependenciesRegex = RegExp(
      r'dependencies:\s*\n',
      multiLine: true,
    );

    if (dependenciesRegex.hasMatch(pubspecContent)) {
      // Add responsive_builder right after the dependencies: line
      final updatedContent = pubspecContent.replaceFirst(
        dependenciesRegex,
        'dependencies:\n  responsive_builder: ^0.7.1\n',
      );

      await _fileService.writeStringFile(
        file: File(pubspecPath),
        fileContent: updatedContent,
        verbose: true,
        type: FileModificationType.Modify,
        verboseMessage: 'Added responsive_builder to pubspec.yaml',
      );

      _log.success(
        message: 'Added responsive_builder: ^0.7.1 to pubspec.yaml',
      );
    } else {
      _log.warn(
        message:
            'Could not find dependencies section in pubspec.yaml. Please add responsive_builder manually.',
      );
    }
  }

  Future<void> _convertViewToResponsive({
    required String viewName,
    required String targetDevice,
    String? projectPath,
    bool skipFormatting = false,
  }) async {
    final recase = ReCase(viewName);
    final viewFileName = '${recase.snakeCase}_view.dart';

    // Build view path based on config and project path
    // The viewPath from config doesn't include 'lib/', so we need to add it
    final baseViewPath = _configService.viewPath;
    final fullViewPath = 'lib/$baseViewPath';
    final viewPath =
        projectPath != null ? '$projectPath/$fullViewPath' : fullViewPath;
    final viewFolderPath = '$viewPath/${recase.snakeCase}';
    final viewFilePath = '$viewFolderPath/$viewFileName';

    // Check if view file exists
    if (!await _fileService.fileExists(filePath: viewFilePath)) {
      _log.error(
        message:
            'View file not found at $viewFilePath. Make sure the view exists before converting.',
      );
      return;
    }

    // Read the existing view file
    final viewFileContent =
        await _fileService.readFileAsString(filePath: viewFilePath);

    final className = '${recase.pascalCase}View';
    final viewModelName = '${recase.pascalCase}ViewModel';

    final isStackedView = _isStackedCompatibleView(
      className: className,
      fileContent: viewFileContent,
    );

    if (!isStackedView) {
      _log.error(
        message:
            '${recase.pascalCase}View is not a stacked view. $kConvertViewMustBeStackedView',
      );
      return;
    }

    // Check if already responsive
    if (viewFileContent.contains('ScreenTypeLayout') ||
        viewFileContent.contains('.mobile.dart') ||
        viewFileContent.contains('.tablet.dart') ||
        viewFileContent.contains('.desktop.dart')) {
      _log.warn(
        message:
            '${recase.pascalCase}View appears to already be responsive. Skipping conversion.',
      );
      return;
    }

    // Extract imports and class content
    final imports = _extractImports(viewFileContent);

    // Determine if it's v1 (ViewModelBuilder) or v2 (StackedView)
    final isV1 = viewFileContent.contains('ViewModelBuilder');

    // Extract the builder body, local variables, UI helper methods, and helper classes
    final builderBody = _extractBuilderBody(viewFileContent, isV1);
    final localVariables = _extractLocalVariables(viewFileContent);
    final uiHelperMethods = _extractUIHelperMethods(viewFileContent);
    final helperClasses = _extractHelperClasses(viewFileContent, className);

    // Create the three variant files with UI helper methods, local variables, and helper classes
    await _createVariantFile(
      folderPath: viewFolderPath,
      viewName: className,
      variant: 'mobile',
      viewModelName: viewModelName,
      builderBody: targetDevice == 'mobile' ? builderBody : null,
      uiHelperMethods: targetDevice == 'mobile' ? uiHelperMethods : '',
      localVariables: targetDevice == 'mobile' ? localVariables : '',
      helperClasses: targetDevice == 'mobile' ? helperClasses : '',
    );

    await _createVariantFile(
      folderPath: viewFolderPath,
      viewName: className,
      variant: 'tablet',
      viewModelName: viewModelName,
      builderBody: targetDevice == 'tablet' ? builderBody : null,
      uiHelperMethods: targetDevice == 'tablet' ? uiHelperMethods : '',
      localVariables: targetDevice == 'tablet' ? localVariables : '',
      helperClasses: targetDevice == 'tablet' ? helperClasses : '',
    );

    await _createVariantFile(
      folderPath: viewFolderPath,
      viewName: className,
      variant: 'desktop',
      viewModelName: viewModelName,
      builderBody: targetDevice == 'desktop' ? builderBody : null,
      uiHelperMethods: targetDevice == 'desktop' ? uiHelperMethods : '',
      localVariables: targetDevice == 'desktop' ? localVariables : '',
      helperClasses: targetDevice == 'desktop' ? helperClasses : '',
    );

    // Create the new main view file
    final newViewContent = _createResponsiveViewFile(
      imports: imports,
      className: className,
      viewModelName: viewModelName,
      viewFileName: viewFileName,
      isV1: isV1,
      originalContent: viewFileContent,
    );

    // Write the updated main view file
    await _fileService.writeStringFile(
      file: File(viewFilePath),
      fileContent: newViewContent,
      verbose: true,
      type: FileModificationType.Modify,
      verboseMessage: 'Converted $viewFilePath to responsive structure',
    );

    // Format this specific view folder if not skipping
    if (!skipFormatting) {
      await _processService.runFormat(filePath: viewFolderPath);
    }

    _log.success(
      message:
          'Successfully converted ${recase.pascalCase}View to responsive structure with $targetDevice as the base UI.',
    );
  }

  String _extractImports(String fileContent) {
    final lines = fileContent.split('\n');
    final importLines = <String>[];

    for (var line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('import ') ||
          trimmed.startsWith('export ') ||
          trimmed.isEmpty && importLines.isNotEmpty) {
        if (trimmed.isNotEmpty) {
          importLines.add(line);
        }
      } else if (importLines.isNotEmpty && !trimmed.startsWith('import')) {
        break;
      }
    }

    return importLines.join('\n');
  }

  String _extractBuilderBody(String fileContent, bool isV1) {
    // Find the builder method
    final builderPattern = RegExp(
      r'Widget builder\s*\(',
      multiLine: true,
    );
    final builderStart = builderPattern.firstMatch(fileContent);

    if (builderStart == null) {
      return '''Scaffold(
      body: Center(
        child: Text('Converted View'),
      ),
    )''';
    }

    // Find the opening brace of the builder method
    int braceCount = 0;
    int openBraceIndex = -1;
    for (int i = builderStart.start; i < fileContent.length; i++) {
      if (fileContent[i] == '{') {
        openBraceIndex = i;
        break;
      }
    }

    if (openBraceIndex == -1) {
      return '''Scaffold(
      body: Center(
        child: Text('Converted View'),
      ),
    )''';
    }

    // Find the return statement within the builder
    final returnPattern = RegExp(r'\breturn\s+', multiLine: true);
    final builderBodyStart = openBraceIndex + 1;
    final builderBodySection = fileContent.substring(builderBodyStart);
    final returnMatch = returnPattern.firstMatch(builderBodySection);

    if (returnMatch == null) {
      return '''Scaffold(
      body: Center(
        child: Text('Converted View'),
      ),
    )''';
    }

    // Extract from return statement to its semicolon using brace counting
    final returnStart = builderBodyStart + returnMatch.end;
    braceCount = 0;
    int parenCount = 0;
    int bracketCount = 0;
    int returnEnd = -1;

    for (int i = returnStart; i < fileContent.length; i++) {
      final char = fileContent[i];

      if (char == '{') {
        braceCount++;
      } else if (char == '}') {
        braceCount--;
      } else if (char == '(') {
        parenCount++;
      } else if (char == ')') {
        parenCount--;
      } else if (char == '[') {
        bracketCount++;
      } else if (char == ']') {
        bracketCount--;
      } else if (char == ';' &&
          braceCount == 0 &&
          parenCount == 0 &&
          bracketCount == 0) {
        returnEnd = i;
        break;
      }
    }

    if (returnEnd != -1) {
      return fileContent.substring(returnStart, returnEnd).trim();
    }

    return '''Scaffold(
      body: Center(
        child: Text('Converted View'),
      ),
    )''';
  }

  String _extractLocalVariables(String fileContent) {
    // Find the builder method
    final builderPattern = RegExp(
      r'Widget builder\s*\(',
      multiLine: true,
    );
    final builderStart = builderPattern.firstMatch(fileContent);

    if (builderStart == null) return '';

    // Find the opening brace of the builder method
    int openBraceIndex = -1;
    for (int i = builderStart.start; i < fileContent.length; i++) {
      if (fileContent[i] == '{') {
        openBraceIndex = i;
        break;
      }
    }

    if (openBraceIndex == -1) return '';

    // Find the return statement
    final returnPattern = RegExp(r'\breturn\s+', multiLine: true);
    final builderBodyStart = openBraceIndex + 1;
    final builderBodySection = fileContent.substring(builderBodyStart);
    final returnMatch = returnPattern.firstMatch(builderBodySection);

    if (returnMatch == null) return '';

    // Extract everything between the opening brace and the return statement
    final localVarsSection =
        builderBodySection.substring(0, returnMatch.start).trim();

    return localVarsSection;
  }

  String _extractUIHelperMethods(String fileContent) {
    // Extract all methods that return Widget or are UI-related
    // These are methods between builder and the Stacked lifecycle methods
    final builderStartPattern = RegExp(
      r'@override\s+Widget\s+builder\s*\(',
      multiLine: true,
    );
    final builderStart = builderStartPattern.firstMatch(fileContent);

    if (builderStart == null) return '';

    // Find the end of the builder method
    int braceCount = 0;
    int builderEndIndex = -1;
    bool insideBuilder = false;

    for (int i = builderStart.start; i < fileContent.length; i++) {
      if (fileContent[i] == '{') {
        braceCount++;
        insideBuilder = true;
      } else if (fileContent[i] == '}') {
        braceCount--;
        if (insideBuilder && braceCount == 0) {
          builderEndIndex = i + 1;
          break;
        }
      }
    }

    if (builderEndIndex == -1) return '';

    // Extract content after builder
    final afterBuilder = fileContent.substring(builderEndIndex);

    // Find where Stacked lifecycle methods start (@override keywords for stacked methods)
    final stackedMethodsPattern = RegExp(
      r'@override\s+(bool\s+get\s+\w+|void\s+onViewModelReady|\w+\s+viewModelBuilder)',
      multiLine: true,
    );
    final stackedMethodsStart = stackedMethodsPattern.firstMatch(afterBuilder);

    // Everything between builder end and stacked methods is UI helper code
    if (stackedMethodsStart != null) {
      return afterBuilder.substring(0, stackedMethodsStart.start).trim();
    }

    // If no stacked methods found, extract everything except the last closing brace
    final lastBraceIndex = afterBuilder.lastIndexOf('}');
    if (lastBraceIndex != -1) {
      return afterBuilder.substring(0, lastBraceIndex).trim();
    }

    return '';
  }

  String _extractHelperClasses(String fileContent, String mainClassName) {
    // Find the main class closing brace
    final mainClassPattern = RegExp(
      r'class\s+' +
          RegExp.escape(mainClassName) +
          r'\s+extends\s+StackedView<\w+>',
      multiLine: true,
    );
    final mainClassMatch = mainClassPattern.firstMatch(fileContent);

    if (mainClassMatch == null) return '';

    // Find the closing brace of the main class
    int braceCount = 0;
    int classEndIndex = -1;
    bool foundOpenBrace = false;

    for (int i = mainClassMatch.start; i < fileContent.length; i++) {
      if (fileContent[i] == '{') {
        braceCount++;
        foundOpenBrace = true;
      } else if (fileContent[i] == '}') {
        braceCount--;
        if (foundOpenBrace && braceCount == 0) {
          classEndIndex = i + 1;
          break;
        }
      }
    }

    if (classEndIndex == -1) return '';

    // Everything after the main class is helper classes
    return fileContent.substring(classEndIndex).trim();
  }

  Future<void> _createVariantFile({
    required String folderPath,
    required String viewName,
    required String variant,
    required String viewModelName,
    String? builderBody,
    String uiHelperMethods = '',
    String localVariables = '',
    String helperClasses = '',
  }) async {
    final variantFileName = '${ReCase(viewName).snakeCase}.$variant.dart';
    final variantFilePath = '$folderPath/$variantFileName';

    final content = builderBody != null
        ? _createVariantWithOriginalUI(
            viewName: viewName,
            variant: variant,
            viewModelName: viewModelName,
            builderBody: builderBody,
            uiHelperMethods: uiHelperMethods,
            localVariables: localVariables,
            helperClasses: helperClasses,
          )
        : _createVariantWithPlaceholderUI(
            viewName: viewName,
            variant: variant,
            viewModelName: viewModelName,
          );

    await _fileService.writeStringFile(
      file: File(variantFilePath),
      fileContent: content,
      verbose: true,
      type: FileModificationType.Create,
      verboseMessage: 'Created $variantFilePath',
    );
  }

  String _createVariantWithOriginalUI({
    required String viewName,
    required String variant,
    required String viewModelName,
    required String builderBody,
    String uiHelperMethods = '',
    String localVariables = '',
    String helperClasses = '',
  }) {
    final variantClass = '$viewName${ReCase(variant).pascalCase}';
    final helperMethodsSection =
        uiHelperMethods.isNotEmpty ? '\n\n  $uiHelperMethods' : '';
    final localVarsSection =
        localVariables.isNotEmpty ? '\n    $localVariables' : '';
    final helperClassesSection =
        helperClasses.isNotEmpty ? '\n\n$helperClasses' : '';

    return '''part of '${ReCase(viewName).snakeCase}.dart';

class $variantClass extends ViewModelWidget<$viewModelName> {
  const $variantClass({super.key});

  @override
  Widget build(BuildContext context, $viewModelName viewModel) {$localVarsSection
    return $builderBody;
  }$helperMethodsSection
}$helperClassesSection
''';
  }

  String _createVariantWithPlaceholderUI({
    required String viewName,
    required String variant,
    required String viewModelName,
  }) {
    final variantClass = '$viewName${ReCase(variant).pascalCase}';
    final variantLabel = variant.toUpperCase();
    return '''part of '${ReCase(viewName).snakeCase}.dart';

class $variantClass extends ViewModelWidget<$viewModelName> {
  const $variantClass({super.key});

  @override
  Widget build(BuildContext context, $viewModelName viewModel) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hello, $variantLabel UI!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
''';
  }

  String _createResponsiveViewFile({
    required String imports,
    required String className,
    required String viewModelName,
    required String viewFileName,
    required bool isV1,
    required String originalContent,
  }) {
    // Add responsive_builder import if not present
    var updatedImports = imports;
    if (!imports.contains('responsive_builder')) {
      updatedImports +=
          "\nimport 'package:responsive_builder/responsive_builder.dart';";
    }

    // Add part directives
    final viewNameSnake = ReCase(className.replaceAll('View', '')).snakeCase;
    final partDirectives = '''
part '${viewNameSnake}_view.mobile.dart';
part '${viewNameSnake}_view.tablet.dart';
part '${viewNameSnake}_view.desktop.dart';
''';

    // Extract constructor parameters and check if it's const
    final constructorConstRegex = RegExp(
      r'const\s+' + className + r'\s*\(\s*\{([^}]*)\}\s*\)\s*;',
      multiLine: true,
    );
    final constructorNonConstRegex = RegExp(
      className + r'\s*\(\s*\{([^}]*)\}\s*\)\s*;',
      multiLine: true,
    );

    var constructorMatch = constructorConstRegex.firstMatch(originalContent);
    var isConstConstructor = constructorMatch != null;

    constructorMatch ??= constructorNonConstRegex.firstMatch(originalContent);

    final constructorParams = constructorMatch?.group(1)?.trim() ?? 'super.key';

    // Extract annotations, mixins, and field declarations using helper classes
    final annotations =
        AnnotationExtractor.extractClassAnnotations(originalContent, className);
    final annotationsSection = annotations.isNotEmpty ? '$annotations\n' : '';
    final mixins =
        AnnotationExtractor.extractClassMixins(originalContent, className);
    final mixinsSection = mixins.isNotEmpty ? ' with $mixins' : '';
    final fieldDeclarations =
        FieldExtractor.extractFieldDeclarations(originalContent);
    final fieldsSection =
        fieldDeclarations.isNotEmpty ? '\n\n  $fieldDeclarations' : '';

    // Extract ONLY Stacked lifecycle methods (not UI helper methods)
    final stackedLifecycleMethods =
        _extractStackedLifecycleMethods(originalContent);

    final constKeyword = isConstConstructor ? 'const ' : '';

    return '''$updatedImports

$partDirectives

${annotationsSection}class $className extends StackedView<$viewModelName>$mixinsSection {
  $constKeyword$className({$constructorParams});$fieldsSection

  @override
  Widget builder(
    BuildContext context,
    $viewModelName viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const ${className}Mobile(),
      tablet: (_) => const ${className}Tablet(),
      desktop: (_) => const ${className}Desktop(),
    );
  }
$stackedLifecycleMethods
}
''';
  }

  String _extractStackedLifecycleMethods(String originalContent) {
    final stackedMethods = <String>[];

    // First, find all @override methods
    final overridePattern = RegExp(
      r'@override',
      multiLine: true,
    );
    final overrideMatches = overridePattern.allMatches(originalContent);

    for (final match in overrideMatches) {
      final startIndex = match.start;
      final afterOverride = originalContent.substring(startIndex);

      String? method = MethodExtractor.extractCompleteMethod(afterOverride);

      if (method != null) {
        // Only include Stacked-specific methods
        if (method.contains('viewModelBuilder') ||
            method.contains('onViewModelReady') ||
            method.contains('onDispose') ||
            method.contains('disposeViewModel') ||
            method.contains('createNewViewModel') ||
            method.contains('fireOnViewModelReadyOnce') ||
            method.contains('initialise')) {
          stackedMethods.add(method);
        }
      }
    }

    // Also look for viewModelBuilder without @override annotation
    final viewModelBuilderPattern = RegExp(
      r'\n\s*(\w+ViewModel)\s+viewModelBuilder\s*\(',
      multiLine: true,
    );
    final vmBuilderMatch = viewModelBuilderPattern.firstMatch(originalContent);

    if (vmBuilderMatch != null) {
      // Check if we already have it from @override extraction
      final alreadyHasVmBuilder =
          stackedMethods.any((m) => m.contains('viewModelBuilder'));

      if (!alreadyHasVmBuilder) {
        final startIndex =
            vmBuilderMatch.start + 1; // +1 to skip the leading newline
        final afterMatch = originalContent.substring(startIndex);
        String? method = MethodExtractor.extractCompleteMethod(afterMatch);

        if (method != null) {
          stackedMethods.add(method);
        }
      }
    }

    return stackedMethods.isNotEmpty
        ? '\n\n  ${stackedMethods.join('\n\n  ')}'
        : '';
  }

  bool _isStackedCompatibleView({
    required String className,
    required String fileContent,
  }) {
    final stackedViewPattern = RegExp(
      r'class\s+' + className + r'\s+extends\s+StackedView<',
      multiLine: true,
    );

    return stackedViewPattern.hasMatch(fileContent);
  }
}

class ConvertAppCommand extends Command with ProjectStructureValidator {
  final _log = locator<ColorizedLogService>();
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _analyticsService = locator<PosthogService>();

  @override
  String get description =>
      'Converts all Stacked views in the project to the responsive layout structure.';

  @override
  String get name => 'app';

  ConvertAppCommand() {
    argParser
      ..addOption(
        ksDevice,
        abbr: 'd',
        allowed: ['mobile', 'tablet', 'desktop'],
        defaultsTo: 'mobile',
        help: kCommandHelpConvertViewDevice,
      )
      ..addOption(
        ksConfigPath,
        abbr: 'c',
        help: kCommandHelpConfigFilePath,
      )
      ..addOption(
        ksLineLength,
        abbr: 'l',
        help: kCommandHelpLineLength,
        valueHelp: '80',
      )
      ..addOption(
        ksProjectPath,
        help: kCommandHelpProjectPath,
      );
  }

  @override
  Future<void> run() async {
    try {
      final String targetDevice = argResults![ksDevice] as String;

      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: argResults![ksProjectPath],
      );

      _processService.formattingLineLength = argResults![ksLineLength];

      await _pubspecService.initialise(
        workingDirectory: argResults![ksProjectPath],
      );

      await validateStructure(outputPath: argResults![ksProjectPath]);

      final convertViewCommand = ConvertViewCommand();

      final dependencies = _pubspecService.pubspecYaml.dependencies;
      if (!dependencies.any((dep) => dep.package() == 'responsive_builder')) {
        _log.info(
          message: 'Adding responsive_builder to pubspec.yaml dependencies...',
        );
        await convertViewCommand._addResponsiveBuilderDependency(
          projectPath: argResults![ksProjectPath],
        );
      }

      final baseViewPath = _configService.viewPath;
      final fullViewPath = 'lib/$baseViewPath';
      final projectPath = argResults![ksProjectPath] as String?;
      final resolvedViewPath = projectPath != null
          ? path.join(projectPath, fullViewPath)
          : fullViewPath;

      List<FileSystemEntity> entities;
      try {
        entities = await _fileService.getFilesInDirectory(
          directoryPath: resolvedViewPath,
        );
      } on FileSystemException {
        _log.error(
          message:
              'Unable to locate view directory at $resolvedViewPath. Ensure your configuration is correct.',
        );
        return;
      }

      final viewFiles = entities.whereType<File>().where((file) {
        final fileName = path.basename(file.path);
        if (!fileName.endsWith('_view.dart')) {
          return false;
        }

        final parentName = path.basename(path.dirname(file.path));
        final viewNameCandidate =
            fileName.substring(0, fileName.length - '_view.dart'.length);

        if (parentName != viewNameCandidate) {
          return false;
        }

        if (fileName.contains('.mobile.dart') ||
            fileName.contains('.tablet.dart') ||
            fileName.contains('.desktop.dart')) {
          return false;
        }

        return true;
      }).toList()
        ..sort(
            (a, b) => path.basename(a.path).compareTo(path.basename(b.path)));

      if (viewFiles.isEmpty) {
        _log.warn(message: kConvertAppNoViewsFound);
        return;
      }

      _log.info(
        message:
            'Processing ${viewFiles.length} view${viewFiles.length == 1 ? '' : 's'} for responsive conversion...',
      );

      for (final file in viewFiles) {
        final fileName = path.basename(file.path);
        final viewName =
            fileName.substring(0, fileName.length - '_view.dart'.length);

        await convertViewCommand._convertViewToResponsive(
          viewName: viewName,
          targetDevice: targetDevice,
          projectPath: argResults![ksProjectPath],
          skipFormatting: true, // Skip formatting during conversion
        );

        await _analyticsService.createViewEvent(
          name: viewName,
          arguments: argResults!.arguments,
        );
      }

      // Format the entire views folder once at the end
      _log.info(message: 'Formatting views folder...');
      await _processService.runFormat(filePath: resolvedViewPath);

      _log.success(
        message:
            'Processed ${viewFiles.length} view${viewFiles.length == 1 ? '' : 's'} for responsive conversion.',
      );
    } catch (e, s) {
      _log.error(message: e.toString());
      unawaited(_analyticsService.logExceptionEvent(
        runtimeType: e.runtimeType.toString(),
        message: e.toString(),
        stackTrace: s.toString(),
      ));
    }
  }
}

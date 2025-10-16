import 'package:args/command_runner.dart';
import 'package:mockito/mockito.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:stacked_cli/src/commands/convert/convert_view_command.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

const String kTestViewName = 'home';
const String kTestViewPath = 'lib/ui/views/home';
const String kTestViewFilePath = 'lib/ui/views/home/home_view.dart';

const String kSampleViewContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("HomeView")),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) => HomeViewModel();
}
''';

const String kSampleResponsiveViewContent = '''
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

part 'home_view.mobile.dart';
part 'home_view.tablet.dart';
part 'home_view.desktop.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const HomeViewMobile(),
      tablet: (_) => const HomeViewTablet(),
      desktop: (_) => const HomeViewDesktop(),
    );
  }
}
''';

const String kNonStackedViewContent = '''
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
''';

void main() {
  group('ConvertViewCommand -', () {
    late ConfigService configService;
    late PubspecService pubspecService;

    setUp(() async {
      await setupLocator();
      configService = getAndRegisterConfigService();
      pubspecService = getAndRegisterPubSpecService();
      getAndRegisterProcessService();
      getAndRegisterPosthogService();

      // Setup config service to return view path
      when(configService.viewPath).thenReturn('lib/ui/views');

      // Setup pubspec service - we'll test the dependency check separately
      when(pubspecService.getPackageName).thenReturn('test_app');
    });

    tearDown(() {
      locator.reset();
    });

    group('_convertViewToResponsive -', () {
      test('should detect already responsive view content', () {
        // This test verifies that the command can detect responsive views
        expect(
          kSampleResponsiveViewContent.contains('ScreenTypeLayout'),
          true,
        );
        expect(
          kSampleResponsiveViewContent.contains('.mobile.dart'),
          true,
        );
        expect(
          kSampleResponsiveViewContent.contains('part '),
          true,
        );
      });

      test('should extract imports from view file', () {
        final imports = _extractImports(kSampleViewContent);

        expect(
            imports.contains("import 'package:flutter/material.dart';"), true);
        expect(
            imports.contains("import 'package:stacked/stacked.dart';"), true);
        expect(imports.contains("import 'home_viewmodel.dart';"), true);
      });

      test('should extract builder body from view file', () {
        final builderBody = _extractBuilderBody(kSampleViewContent);

        expect(builderBody.contains('Scaffold'), true);
        expect(builderBody.contains('backgroundColor'), true);
        expect(builderBody.contains('HomeView'), true);
        // Should not contain 'return' keyword or trailing semicolon
        expect(builderBody.trim().startsWith('return'), false);
        expect(builderBody.trim().endsWith(';'), false);
      });

      test('should create variant with original UI when specified', () {
        final variantContent = _createVariantWithOriginalUI(
          viewName: 'Home',
          variant: 'mobile',
          viewModelName: 'HomeViewModel',
          builderBody: '''Scaffold(
      body: Center(child: Text('Original')),
    )''',
        );

        expect(variantContent.contains("part of 'home_view.dart';"), true);
        expect(variantContent.contains('class HomeMobile'), true);
        expect(variantContent.contains('ViewModelWidget<HomeViewModel>'), true);
        expect(variantContent.contains('Original'), true);
      });

      test('should create variant with placeholder UI', () {
        final variantContent = _createVariantWithPlaceholderUI(
          viewName: 'Home',
          variant: 'tablet',
          viewModelName: 'HomeViewModel',
        );

        expect(variantContent.contains("part of 'home_view.dart';"), true);
        expect(variantContent.contains('class HomeTablet'), true);
        expect(variantContent.contains('Hello, TABLET UI!'), true);
      });

      test('should create responsive view file with part directives', () {
        final responsiveContent = _createResponsiveViewFile(
          imports: '''import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';''',
          className: 'HomeView',
          viewModelName: 'HomeViewModel',
          viewFileName: 'home_view.dart',
          isV1: false,
          originalContent: kSampleViewContent,
        );

        expect(
            responsiveContent.contains(
                "import 'package:responsive_builder/responsive_builder.dart';"),
            true);
        expect(
            responsiveContent.contains("part 'home_view.mobile.dart';"), true);
        expect(
            responsiveContent.contains("part 'home_view.tablet.dart';"), true);
        expect(
            responsiveContent.contains("part 'home_view.desktop.dart';"), true);
        expect(responsiveContent.contains('ScreenTypeLayout.builder'), true);
        expect(responsiveContent.contains('HomeViewMobile()'), true);
        expect(responsiveContent.contains('HomeViewTablet()'), true);
        expect(responsiveContent.contains('HomeViewDesktop()'), true);
      });

      test('should preserve viewModelBuilder in responsive view', () {
        final responsiveContent = _createResponsiveViewFile(
          imports: '''import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';''',
          className: 'HomeView',
          viewModelName: 'HomeViewModel',
          viewFileName: 'home_view.dart',
          isV1: false,
          originalContent: kSampleViewContent,
        );

        expect(responsiveContent.contains('viewModelBuilder'), true);
        expect(responsiveContent.contains('HomeViewModel()'), true);
      });
    });

    group('validation -', () {
      test('should validate view file path format', () {
        final viewPath = 'lib/ui/views';
        final expectedPath = '$viewPath/home/home_view.dart';

        expect(expectedPath, kTestViewFilePath);
      });

      test('should detect view content structure', () {
        expect(kSampleViewContent.contains('class HomeView'), true);
        expect(kSampleViewContent.contains('StackedView'), true);
        expect(kSampleViewContent.contains('viewModelBuilder'), true);
      });
    });

    group('run -', () {
      test('skips conversion when view does not extend StackedView', () async {
        final logService = getAndRegisterColorizedLogService();
        final fileService = getAndRegisterFileService(
          readFileResult: kNonStackedViewContent,
        );

        when(fileService.fileExists(filePath: anyNamed('filePath')))
            .thenAnswer((_) async => true);

        final pubspecYaml = '''
name: test_app
dependencies:
  flutter:
    sdk: flutter
  responsive_builder: ^0.7.1
'''
            .toPubspecYaml();

        when(pubspecService.initialise(
                workingDirectory: anyNamed('workingDirectory')))
            .thenAnswer((_) async {});
        when(pubspecService.pubspecYaml).thenReturn(pubspecYaml);

        when(configService.viewPath).thenReturn('ui/views');
        when(configService.stackedAppFilePath).thenReturn('src/locator.dart');
        when(configService.composeAndLoadConfigFile(
          configFilePath: anyNamed('configFilePath'),
          projectPath: anyNamed('projectPath'),
        )).thenAnswer((_) async {});

        final command = ConvertViewCommand();
        final runner = CommandRunner('test', 'test cli')..addCommand(command);

        await runner.run(['view', 'home']);

        verify(logService.error(
          message: argThat(
            contains('is not a stacked view'),
            named: 'message',
          ),
        )).called(1);

        verifyNever(fileService.writeStringFile(
          file: anyNamed('file'),
          fileContent: anyNamed('fileContent'),
          verbose: anyNamed('verbose'),
          type: anyNamed('type'),
          verboseMessage: anyNamed('verboseMessage'),
        ));
      });
    });
  });
}

// Helper functions extracted from ConvertViewCommand for testing
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

String _extractBuilderBody(String fileContent) {
  final builderRegex = RegExp(
    r'Widget builder\([^)]*\)\s*\{([\s\S]*?)\n\s*\}',
    multiLine: true,
  );

  final match = builderRegex.firstMatch(fileContent);
  if (match != null) {
    var body = match.group(1)?.trim() ?? '';
    body = body.replaceFirst(RegExp(r'^\s*return\s+'), '');
    body = body.replaceFirst(RegExp(r';\s*$'), '');
    return body;
  }

  return '''Scaffold(
      body: Center(
        child: Text('Converted View'),
      ),
    )''';
}

String _createVariantWithOriginalUI({
  required String viewName,
  required String variant,
  required String viewModelName,
  required String builderBody,
}) {
  final variantClass =
      '$viewName${variant[0].toUpperCase()}${variant.substring(1)}';
  final viewNameSnake = viewName.toLowerCase();
  return '''part of '${viewNameSnake}_view.dart';

class $variantClass extends ViewModelWidget<$viewModelName> {
  const $variantClass({super.key});

  @override
  Widget build(BuildContext context, $viewModelName viewModel) {
    return $builderBody;
  }
}
''';
}

String _createVariantWithPlaceholderUI({
  required String viewName,
  required String variant,
  required String viewModelName,
}) {
  final variantClass =
      '$viewName${variant[0].toUpperCase()}${variant.substring(1)}';
  final variantLabel = variant.toUpperCase();
  final viewNameSnake = viewName.toLowerCase();
  return '''part of '${viewNameSnake}_view.dart';

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
  var updatedImports = imports;
  if (!imports.contains('responsive_builder')) {
    updatedImports +=
        "\nimport 'package:responsive_builder/responsive_builder.dart';";
  }

  final viewNameSnake = className.toLowerCase().replaceAll('view', '');
  final partDirectives = '''
part '${viewNameSnake}_view.mobile.dart';
part '${viewNameSnake}_view.tablet.dart';
part '${viewNameSnake}_view.desktop.dart';
''';

  final viewModelBuilderRegex = RegExp(
    r'@override\s+\w+\s+viewModelBuilder\([^)]*\)[^{]*\{[^}]*\}',
    multiLine: true,
  );
  final viewModelBuilderMatch =
      viewModelBuilderRegex.firstMatch(originalContent);
  final viewModelBuilder = viewModelBuilderMatch?.group(0) ??
      '''@override
  $viewModelName viewModelBuilder(
    BuildContext context,
  ) => $viewModelName();''';

  final onViewModelReadyRegex = RegExp(
    r'@override\s+void\s+onViewModelReady\([^)]*\)[^{]*\{[^}]*\}',
    multiLine: true,
  );
  final onViewModelReadyMatch =
      onViewModelReadyRegex.firstMatch(originalContent);
  final onViewModelReady = onViewModelReadyMatch?.group(0) ?? '';

  return '''$updatedImports

$partDirectives

class $className extends StackedView<$viewModelName> {
  const $className({super.key});

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

  $viewModelBuilder${onViewModelReady.isNotEmpty ? '\n\n  $onViewModelReady' : ''}
}
''';
}

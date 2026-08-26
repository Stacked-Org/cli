import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/posthog_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/compiled_constants.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class CreateViewCommand extends Command with ProjectStructureValidator {
  final _log = locator<ColorizedLogService>();
  final _configService = locator<ConfigService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<PosthogService>();

  @override
  String get description =>
      'Creates a view with all associated files and makes necessary code changes for adding a view.';

  @override
  String get name => kTemplateNameView;

  CreateViewCommand() {
    argParser
      ..addFlag(
        ksExcludeRoute,
        defaultsTo: false,
        help: kCommandHelpExcludeRoute,
      )
      ..addFlag(
        ksV1,
        aliases: [ksUseBuilder],
        defaultsTo: null,
        help: kCommandHelpV1,
      )
      ..addOption(
        ksTemplateType,
        abbr: 't',
        allowed: kCompiledTemplateTypes[kTemplateNameView],
        help: kCommandHelpCreateViewTemplate,
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
      var templateType = argResults![ksTemplateType] as String?;
      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: argResults![ksProjectPath],
      );
      _processService.formattingLineLength = argResults![ksLineLength];
      await _pubspecService.initialise(
          workingDirectory: argResults![ksProjectPath]);
      await validateStructure(outputPath: argResults![ksProjectPath]);

      // Determine which template to use with the following rules:
      // 1. If the template is supplied we use that template
      // 2. If the template is null use config web to decide
      print('templateType:$templateType preferWeb:${_configService.preferWeb}');

      // We assign this when it's not null so there should be no default value for this
      templateType ??= _configService.preferWeb ? 'web' : 'empty';

      for (var i = 0; i < viewNames.length; i++) {
        // Parse the view name to support subdirectories
        // e.g., "sales/dashboard" -> subfolder: "sales", viewName: "dashboard"
        final viewPath = viewNames[i];
        final pathParts = viewPath.split('/');
        final viewName = pathParts.last;
        final subfolders = pathParts.length > 1
            ? pathParts.sublist(0, pathParts.length - 1).join('/')
            : null;

        await _templateService.renderTemplate(
          templateName: name,
          name: viewName,
          subfolder: subfolders,
          outputPath: argResults![ksProjectPath],
          verbose: true,
          excludeRoute: argResults![ksExcludeRoute],
          useBuilder: argResults![ksV1] ?? _configService.v1,
          templateType: templateType,
        );

        await _analyticsService.createViewEvent(
          name: viewPath,
          arguments: argResults!.arguments,
        );
      }

      await _processService.runBuildRunner(
          workingDirectory: argResults![ksProjectPath]);
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

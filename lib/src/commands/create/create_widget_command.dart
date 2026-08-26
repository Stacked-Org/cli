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

class CreateWidgetCommand extends Command with ProjectStructureValidator {
  final _log = locator<ColorizedLogService>();
  final _configService = locator<ConfigService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<PosthogService>();

  @override
  String get description => 'Creates a widget with their model file.';

  @override
  String get name => kTemplateNameWidget;

  CreateWidgetCommand() {
    argParser
      ..addFlag(
        ksModel,
        defaultsTo: true,
        help: kCommandHelpModel,
      )
      ..addOption(
        ksTemplateType,
        abbr: 't',
        allowed: kCompiledTemplateTypes[kTemplateNameWidget],
        defaultsTo: 'empty',
        help: kCommandHelpCreateWidgetTemplate,
      )
      ..addOption(
        ksConfigPath,
        abbr: 'c',
        help: kCommandHelpConfigFilePath,
      )
      ..addOption(
        ksPath,
        abbr: 'p',
        help: kCommandHelpPath,
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
      final List<String> widgetNames = argResults!.rest;
      final templateType = argResults![ksTemplateType];
      // load configuration
      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: argResults![ksProjectPath],
      );
      // override [widgets_path] value on configuration
      _configService.setWidgetsPath(argResults![ksPath]);

      _processService.formattingLineLength = argResults![ksLineLength];
      await _pubspecService.initialise(
          workingDirectory: argResults![ksProjectPath]);
      await validateStructure(outputPath: argResults![ksProjectPath]);

      for (var i = 0; i < widgetNames.length; i++) {
        // Parse the widget name to support subdirectories
        final widgetPath = widgetNames[i];
        final pathParts = widgetPath.split('/');
        final widgetName = pathParts.last;
        final subfolders = pathParts.length > 1
            ? pathParts.sublist(0, pathParts.length - 1).join('/')
            : null;

        await _templateService.renderTemplate(
          templateName: name,
          name: widgetName,
          subfolder: subfolders,
          outputPath: argResults![ksProjectPath],
          verbose: true,
          hasModel: argResults![ksModel],
          templateType: templateType,
        );

        await _analyticsService.createWidgetEvent(
          name: widgetPath,
          arguments: argResults!.arguments,
        );
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
}

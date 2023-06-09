import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
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
  final _analyticsService = locator<AnalyticsService>();

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
      );
  }

  @override
  Future<void> run() async {
    try {
      final widgetName = argResults!.rest.first;
      final templateType = argResults![ksTemplateType];
      final workingDirectory =
          argResults!.rest.length > 1 ? argResults!.rest[1] : null;

      // load configuration
      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      // override [widgets_path] value on configuration
      _configService.setWidgetsPath(argResults![ksPath]);

      _processService.formattingLineLength = argResults![ksLineLength];
      await _pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);

      await _templateService.renderTemplate(
        templateName: name,
        name: widgetName,
        outputPath: workingDirectory,
        verbose: true,
        hasModel: argResults![ksModel],
        templateType: templateType,
      );

      unawaited(_analyticsService.createWidgetEvent(name: widgetName));
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

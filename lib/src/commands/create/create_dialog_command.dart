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

class CreateDialogCommand extends Command with ProjectStructureValidator {
  final _log = locator<ColorizedLogService>();
  final _configService = locator<ConfigService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<PosthogService>();

  @override
  String get description =>
      'Creates a dialog with all associated files and makes necessary code changes for adding a dialog.';

  @override
  String get name => kTemplateNameDialog;

  CreateDialogCommand() {
    argParser
      ..addFlag(
        ksExcludeRoute,
        defaultsTo: false,
        help: kCommandHelpExcludeRoute,
      )
      ..addFlag(
        ksModel,
        defaultsTo: true,
        help: kCommandHelpModel,
      )
      ..addOption(
        ksTemplateType,
        abbr: 't',
        allowed: kCompiledTemplateTypes[kTemplateNameDialog],
        defaultsTo: 'empty',
        help: kCommandHelpCreateDialogTemplate,
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
      final List<String> dialogNames = argResults!.rest;
      final templateType = argResults![ksTemplateType];
      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: argResults![ksProjectPath],
      );
      _processService.formattingLineLength = argResults![ksLineLength];
      await _pubspecService.initialise(
          workingDirectory: argResults![ksProjectPath]);
      await validateStructure(outputPath: argResults![ksProjectPath]);

      for (var i = 0; i < dialogNames.length; i++) {
        await _templateService.renderTemplate(
          templateName: name,
          name: dialogNames[i],
          outputPath: argResults![ksProjectPath],
          verbose: true,
          excludeRoute: argResults![ksExcludeRoute],
          hasModel: argResults![ksModel],
          templateType: templateType,
        );

        await _analyticsService.createDialogEvent(
          name: dialogNames[i],
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

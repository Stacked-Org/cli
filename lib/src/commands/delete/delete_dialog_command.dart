import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class DeleteDialogCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _log = locator<ColorizedLogService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  String get description =>
      'Deletes a dialog with all associated files and makes necessary code changes for deleting a dialog.';

  @override
  String get name => kTemplateNameDialog;

  DeleteDialogCommand() {
    argParser
      ..addFlag(
        ksExcludeRoute,
        defaultsTo: false,
        help: kCommandHelpExcludeRoute,
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
      );
  }

  @override
  Future<void> run() async {
    try {
      final workingDirectory =
          argResults!.rest.length > 1 ? argResults!.rest[1] : null;
      final dialogName = argResults!.rest.first;
      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      _processService.formattingLineLength = argResults?[ksLineLength];
      await _pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);
      await _deleteDialog(outputPath: workingDirectory, dialogName: dialogName);
      await _removeDialogFromDependency(
          outputPath: workingDirectory, dialogName: dialogName);
      await _processService.runBuildRunner(workingDirectory: workingDirectory);
      unawaited(
        _analyticsService.deleteDialogEvent(name: argResults!.rest.first),
      );
    } on PathNotFoundException catch (e) {
      _log.error(message: e.message);
    } catch (e, s) {
      _log.error(message: e.toString());
      unawaited(_analyticsService.logExceptionEvent(
        runtimeType: e.runtimeType.toString(),
        message: e.toString(),
        stackTrace: s.toString(),
      ));
    }
  }

  /// It deletes the dialog files
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `dialogName` (String): The name of the dialog.
  Future<void> _deleteDialog(
      {String? outputPath, required String dialogName}) async {
    /// Deleting the dialog folder.
    String directoryPath = _templateService.getTemplateOutputPath(
      inputTemplatePath: 'lib/ui/dialogs/generic',
      name: dialogName,
      outputFolder: outputPath,
    );
    await _fileService.deleteFolder(directoryPath: directoryPath);

    //Delete test file for dialog
    final filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kDialogEmptyTemplateGenericDialogModelTestPath,
      name: dialogName,
      outputFolder: outputPath,
    );
    await _fileService.deleteFile(filePath: filePath);
  }

  /// It removes the dialog from [app.dart]
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `dialogName` (String): The name of the dialog.
  Future<void> _removeDialogFromDependency(
      {String? outputPath, required String dialogName}) async {
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kAppMobileTemplateAppPath,
      name: dialogName,
      outputFolder: outputPath,
    );
    await _fileService.removeSpecificFileLines(
      filePath: filePath,
      removedContent: dialogName,
      type: kTemplateNameDialog,
    );
  }
}

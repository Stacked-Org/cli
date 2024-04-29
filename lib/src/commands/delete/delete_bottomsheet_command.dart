import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
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
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class DeleteBottomsheetCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _log = locator<ColorizedLogService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<PosthogService>();

  @override
  String get description =>
      'Deletes a bottomsheet with all associated files and makes necessary code changes for deleting a bottomsheet.';

  @override
  String get name => kTemplateNameBottomSheet;

  DeleteBottomsheetCommand() {
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
      final bottomsheetName = argResults!.rest.first;
      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      _processService.formattingLineLength = argResults?[ksLineLength];
      await _pubspecService.initialise(workingDirectory: workingDirectory);

      await validateStructure(outputPath: workingDirectory);
      await _deletebottomsheet(
          outputPath: workingDirectory, bottomsheetName: bottomsheetName);
      await _removebottomsheetFromDependency(
          outputPath: workingDirectory, bottomsheetName: bottomsheetName);
      await _processService.runBuildRunner(workingDirectory: workingDirectory);
      await _analyticsService.deleteBottomsheetEvent(
        name: argResults!.rest.first,
        arguments: argResults!.arguments,
      );
    } on PathNotFoundException catch (e) {
      _log.error(message: e.toString());
      unawaited(_analyticsService.logExceptionEvent(
        runtimeType: e.runtimeType.toString(),
        message: e.toString(),
      ));
    } catch (e, s) {
      _log.error(message: e.toString());
      unawaited(_analyticsService.logExceptionEvent(
        runtimeType: e.runtimeType.toString(),
        message: e.toString(),
        stackTrace: s.toString(),
      ));
    }
  }

  /// It deletes the bottomsheet files
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `bottomsheetName` (String): The name of the bottomsheet.
  Future<void> _deletebottomsheet(
      {String? outputPath, required String bottomsheetName}) async {
    /// Deleting the bottomsheet folder.
    String directoryPath = _templateService.getTemplateOutputPath(
      inputTemplatePath: 'lib/ui/bottom_sheets/generic',
      name: bottomsheetName,
      outputFolder: outputPath,
    );
    await _fileService.deleteFolder(directoryPath: directoryPath);

    //Delete test file for bottomsheet
    final filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kBottomSheetEmptyTemplateGenericSheetModelTestPath,
      name: bottomsheetName,
      outputFolder: outputPath,
    );

    final fileExists = await _fileService.fileExists(filePath: filePath);
    if (fileExists) {
      await _fileService.deleteFile(filePath: filePath);
    }
  }

  /// It removes the bottomsheet from [app.dart]
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `bottomsheetName` (String): The name of the bottomsheet.
  Future<void> _removebottomsheetFromDependency(
      {String? outputPath, required String bottomsheetName}) async {
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kAppMobileTemplateAppPath,
      name: bottomsheetName,
      outputFolder: outputPath,
    );
    await _fileService.removeSpecificFileLines(
      filePath: filePath,
      removedContent: bottomsheetName,
      type: "sheet",
    );
  }
}

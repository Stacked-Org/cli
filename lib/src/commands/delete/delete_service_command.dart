import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class DeleteServiceCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  String get description =>
      'Deletes a service with all associated files and makes necessary code changes for deleting a service.';

  @override
  String get name => kTemplateNameService;

  DeleteServiceCommand() {
    argParser.addFlag(
      ksExcludeRoute,
      defaultsTo: false,
      help: kCommandHelpExcludeRoute,
    );
    argParser.addOption(
      ksLineLength,
      abbr: 'l',
      help: 'The length of the line that is used for formatting',
      valueHelp: '80',
    );

    argParser.addOption(
      ksConfigPath,
      abbr: 'c',
      help: kCommandHelpConfigFilePath,
    );
  }

  @override
  Future<void> run() async {
    unawaited(_analyticsService.deleteServiceEvent(
      name: argResults!.rest.first,
    ));
    final workingDirectory =
        argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    await _configService.composeAndLoadConfigFile(
      configFilePath: argResults![ksConfigPath],
      projectPath: workingDirectory,
    );
    _processService.formattingLineLength = argResults?[ksLineLength];
    await _pubspecService.initialise(workingDirectory: workingDirectory);
    await validateStructure(outputPath: workingDirectory);
    await deleteServiceAndTestFiles(outputPath: workingDirectory);
    await removeServiceFromTestHelper(outputPath: workingDirectory);
    await removeServiceFromDependency(outputPath: workingDirectory);
    await _processService.runBuildRunner(workingDirectory: workingDirectory);
  }

  /// It deletes the service and test files
  ///
  /// Args:
  ///   outputPath (String): The path to the output folder.
  Future<void> deleteServiceAndTestFiles({String? outputPath}) async {
    /// Deleting the service file.
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kServiceEmptyTemplateGenericServicePath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.deleteFile(filePath: filePath);

    //Delete test file for service
    filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kServiceEmptyTemplateGenericServiceTestPath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.deleteFile(filePath: filePath);
  }

  Future<void> removeServiceFromTestHelper({String? outputPath}) async {
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kAppMobileTemplateTestHelpersPath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.removeSpecificFileLines(
      filePath: filePath,
      removedContent: argResults!.rest.first,
      type: kTemplateNameService,
    );
  }

  /// It removes the service from [app.dart]
  ///
  /// Args:
  ///   outputPath (String): The path to the output folder.
  Future<void> removeServiceFromDependency({String? outputPath}) async {
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kAppMobileTemplateAppPath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.removeSpecificFileLines(
      filePath: filePath,
      removedContent: argResults!.rest.first,
      type: kTemplateNameService,
    );
  }
}

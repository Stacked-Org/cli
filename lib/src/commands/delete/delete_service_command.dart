import 'dart:async';

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

class DeleteServiceCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _log = locator<ColorizedLogService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<PosthogService>();

  @override
  String get description =>
      'Deletes a service with all associated files and makes necessary code changes for deleting a service.';

  @override
  String get name => kTemplateNameService;

  DeleteServiceCommand() {
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

      // Parse service path to support subdirectories
      final servicePath = argResults!.rest.first;
      final pathParts = servicePath.split('/');
      final serviceName = pathParts.last;
      final subfolder = pathParts.length > 1
          ? pathParts.sublist(0, pathParts.length - 1).join('/')
          : null;

      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      _processService.formattingLineLength = argResults?[ksLineLength];
      await _pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);
      await _deleteServiceAndTestFiles(
          outputPath: workingDirectory,
          serviceName: serviceName,
          subfolder: subfolder);
      await _removeServiceFromTestHelper(
          outputPath: workingDirectory,
          serviceName: serviceName,
          subfolder: subfolder);
      await _removeServiceFromDependency(
          outputPath: workingDirectory,
          serviceName: serviceName,
          subfolder: subfolder);
      await _processService.runBuildRunner(workingDirectory: workingDirectory);
      await _analyticsService.deleteServiceEvent(
        name: argResults!.rest.first,
        arguments: argResults!.arguments,
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

  /// It deletes the service and test files
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `serviceName` (String): The name of the service to be deleted.
  ///
  ///  `subfolder` (String): Optional subfolder path for organized services.
  Future<void> _deleteServiceAndTestFiles({
    String? outputPath,
    required String serviceName,
    String? subfolder,
  }) async {
    /// Deleting the service file.
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kServiceEmptyTemplateGenericServicePath,
      name: serviceName,
      subfolder: subfolder,
      outputFolder: outputPath,
    );
    await _fileService.deleteFile(filePath: filePath);

    //Delete test file for service
    filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kServiceEmptyTemplateGenericServiceTestPath,
      name: serviceName,
      subfolder: subfolder,
      outputFolder: outputPath,
    );
    await _fileService.deleteFile(filePath: filePath);
  }

  /// It removes the service from [test_helper.dart]
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `serviceName` (String): The name of the service to be deleted.
  ///
  ///  `subfolder` (String): Optional subfolder path for organized services.
  Future<void> _removeServiceFromTestHelper({
    String? outputPath,
    required String serviceName,
    String? subfolder,
  }) async {
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kAppMobileTemplateTestHelpersPath,
      name: serviceName,
      subfolder: subfolder,
      outputFolder: outputPath,
    );
    await _fileService.removeSpecificFileLines(
      filePath: filePath,
      removedContent: serviceName,
      type: kTemplateNameService,
    );
  }

  /// It removes the service from [app.dart]
  ///
  /// Args:
  ///
  ///  `outputPath` (String): The path to the output folder.
  ///
  ///  `serviceName` (String): The name of the service to be deleted.
  ///
  ///  `subfolder` (String): Optional subfolder path for organized services.
  Future<void> _removeServiceFromDependency({
    String? outputPath,
    required String serviceName,
    String? subfolder,
  }) async {
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kAppMobileTemplateAppPath,
      name: serviceName,
      subfolder: subfolder,
      outputFolder: outputPath,
    );
    await _fileService.removeSpecificFileLines(
      filePath: filePath,
      removedContent: serviceName,
      type: kTemplateNameService,
    );
  }
}

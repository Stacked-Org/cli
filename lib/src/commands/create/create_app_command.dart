import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/config_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/compiled_constants.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';
import 'package:stacked_cli/src/templates/template_helper.dart';

class CreateAppCommand extends Command {
  final _analyticsService = locator<AnalyticsService>();
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _log = locator<ColorizedLogService>();
  final _processService = locator<ProcessService>();
  final _templateHelper = locator<TemplateHelper>();
  final _templateService = locator<TemplateService>();

  @override
  String get description =>
      'Creates a Stacked application with all the basics setup.';

  @override
  String get name => kTemplateNameApp;

  CreateAppCommand() {
    argParser
      ..addFlag(
        ksAppMinimalTemplate,
        abbr: 'e',
        defaultsTo: true,
        help: kCommandHelpAppMinimalTemplate,
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
        allowed: kCompiledTemplateTypes[kTemplateNameApp],
        defaultsTo: 'mobile',
        help: kCommandHelpCreateAppTemplate,
      )
      ..addOption(
        ksConfigPath,
        abbr: 'c',
        help: kCommandHelpConfigFilePath,
      )
      ..addOption(
        ksAppDescription,
        help: kCommandHelpAppDescription,
      )
      ..addOption(
        ksAppOrganization,
        help: kCommandHelpAppOrganization,
      )
      ..addMultiOption(
        ksAppPlatforms,
        allowed: ['ios', 'android', 'windows', 'linux', 'macos', 'web'],
        help: kCommandHelpAppPlatforms,
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
      await _configService.findAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
      );

      final workingDirectory = argResults!.rest.first;
      final appName = workingDirectory.split('/').last;
      final templateType = argResults![ksTemplateType];

      unawaited(_analyticsService.createAppEvent(name: appName));
      _processService.formattingLineLength = argResults![ksLineLength];
      await _processService.runCreateApp(
        shouldUseMinimalTemplate: argResults![ksAppMinimalTemplate],
        name: workingDirectory,
        description: argResults![ksAppDescription],
        organization: argResults![ksAppOrganization],
        platforms: argResults![ksAppPlatforms],
      );

      _log.stackedOutput(message: 'Add Stacked Magic ... ', isBold: true);

      if (argResults![ksAppDescription] != null) {
        _templateHelper.packageDescription = argResults![ksAppDescription];
      }
      await _templateService.renderTemplate(
        templateName: name,
        name: appName,
        verbose: true,
        outputPath: workingDirectory,
        useBuilder: argResults![ksV1] ?? _configService.v1,
        templateType: templateType,
      );

      _replaceConfigFile(appName: workingDirectory);
      await _processService.runPubGet(appName: workingDirectory);
      await _processService.runBuildRunner(workingDirectory: workingDirectory);
      await _processService.runFormat(appName: workingDirectory);
      await _clean(workingDirectory: workingDirectory);
    } catch (e) {
      _log.warn(message: e.toString());
    }
  }

  /// Cleans the project.
  ///
  ///   - Deletes widget_test.dart file
  ///   - Removes unused imports
  Future<void> _clean({required String workingDirectory}) async {
    _log.stackedOutput(message: 'Cleaning project...');

    // Removes `widget_test` file to avoid failing unit tests on created app
    if (await _fileService.fileExists(
      filePath: '$workingDirectory/test/widget_test.dart',
    )) {
      await _fileService.deleteFile(
        filePath: '$workingDirectory/test/widget_test.dart',
        verbose: false,
      );
    }

    // Analyze the project and return output lines
    final issues = await _processService.runAnalyze(appName: workingDirectory);

    for (var i in issues) {
      if (!i.endsWith('unused_import')) continue;

      final log = i.split(' • ')[2].split(':');

      await _fileService.removeLinesOnFile(
        filePath: '$workingDirectory/${log[0]}',
        linesNumber: [int.parse(log[1])],
      );
    }

    _log.stackedOutput(message: 'Project cleaned.');
  }

  /// Replaces configuration file in the project created.
  ///
  /// If has NO custom config, does nothing.
  void _replaceConfigFile({required String appName}) {
    if (!_configService.hasCustomConfig) return;

    File('$appName/$kConfigFileName').writeAsStringSync(
      _configService.exportConfig(),
    );
  }
}

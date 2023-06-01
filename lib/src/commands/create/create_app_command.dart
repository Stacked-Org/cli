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
import 'package:stacked_cli/src/templates/template_constants.dart';

class CreateAppCommand extends Command {
  final _log = locator<ColorizedLogService>();
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _processService = locator<ProcessService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  String get description =>
      'Creates a Stacked application with all the basics setup.';

  @override
  String get name => kTemplateNameApp;

  CreateAppCommand() {
    argParser.addFlag(
      ksV1,
      aliases: [ksUseBuilder],
      defaultsTo: null,
      help: kCommandHelpV1,
    );

    argParser.addOption(
      ksLineLength,
      abbr: 'l',
      help: kCommandHelpLineLength,
      valueHelp: '80',
    );

    argParser.addOption(
      ksTemplateType,
      abbr: 't',
      // TODO (Create App Templates): Generate a constant with these values when
      // running the compile command
      allowed: ['mobile', 'web'],
      defaultsTo: 'mobile',
      help: kCommandHelpCreateAppTemplate,
    );

    argParser.addOption(
      ksConfigPath,
      abbr: 'c',
      help: kCommandHelpConfigFilePath,
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
      await _processService.runCreateApp(appName: workingDirectory);

      _log.stackedOutput(message: 'Add Stacked Magic ... ', isBold: true);

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

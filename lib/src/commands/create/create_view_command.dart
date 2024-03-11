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
      );
  }

  @override
  Future<void> run() async {
    try {
      final viewName = argResults!.rest.first;
      var templateType = argResults![ksTemplateType] as String?;
      final workingDirectory =
          argResults!.rest.length > 1 ? argResults!.rest[1] : null;
      await _configService.composeAndLoadConfigFile(
        configFilePath: argResults![ksConfigPath],
        projectPath: workingDirectory,
      );
      _processService.formattingLineLength = argResults![ksLineLength];
      await _pubspecService.initialise(workingDirectory: workingDirectory);
      await validateStructure(outputPath: workingDirectory);

      // Determine which template to use with the following rules:
      // 1. If the template is supplied we use that template
      // 2. If the template is null use config web to decide
      print('templateType:$templateType preferWeb:${_configService.preferWeb}');
      templateType ??= _configService.preferWeb ? 'web' : 'empty';

      await _templateService.renderTemplate(
        templateName: name,
        name: viewName,
        outputPath: workingDirectory,
        verbose: true,
        excludeRoute: argResults![ksExcludeRoute],
        useBuilder: argResults![ksV1] ?? _configService.v1,
        templateType: templateType,
      );
      await _processService.runBuildRunner(workingDirectory: workingDirectory);
      await _analyticsService.createViewEvent(
        name: viewName,
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
}

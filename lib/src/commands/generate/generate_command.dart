import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/posthog_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class GenerateCommand extends Command {
  final _analyticsService = locator<PosthogService>();
  final _log = locator<ColorizedLogService>();
  final _processService = locator<ProcessService>();

  @override
  String get description =>
      '''Generates the code for the stacked application if any changes were made.''';

  @override
  String get name => kTemplateNameGenerate;

  GenerateCommand() {
    argParser
      ..addFlag(
        ksDeleteConflictOutputs,
        abbr: 'd',
        defaultsTo: true,
        negatable: true,
        help: kCommandHelpDeleteConflictingOutputs,
      )
      ..addFlag(
        ksWatch,
        abbr: 'w',
        defaultsTo: false,
        help: kCommandHelpWatch,
      );
  }

  @override
  Future<void> run() async {
    try {
      await _processService.runBuildRunner(
        shouldDeleteConflictingOutputs: argResults?[ksDeleteConflictOutputs],
        shouldWatch: argResults?[ksWatch],
      );
      await _analyticsService.generateCodeEvent(
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

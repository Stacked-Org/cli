import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class GenerateCommand extends Command {
  final _analyticsService = locator<AnalyticsService>();
  final _processService = locator<ProcessService>();

  @override
  String get description =>
      '''Generates the code for the stacked application if any changes were made''';

  @override
  String get name => kTemplateNameGenerate;

  GenerateCommand() {
    argParser.addFlag(
      ksDeleteConflictOutputs,
      abbr: 'd',
      defaultsTo: true,
      negatable: true,
      help: kCommandHelpDeleteConflictingOutputs,
    );

    argParser.addFlag(
      ksWatch,
      abbr: 'w',
      defaultsTo: false,
      help: kCommandHelpWatch,
    );
  }

  @override
  Future<void> run() async {
    unawaited(_analyticsService.generateCodeEvent());
    await _processService.runBuildRunner(
      shouldDeleteConflictingOutputs: argResults?[ksDeleteConflictOutputs],
      shouldWatch: argResults?[ksWatch],
    );
  }
}

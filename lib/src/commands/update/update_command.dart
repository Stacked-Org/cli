import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pub_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class UpdateCommand extends Command {
  final _analyticsService = locator<AnalyticsService>();
  final _processService = locator<ProcessService>();
  final _pubService = locator<PubService>();

  @override
  String get description => '''Updates stacked_cli to latest version.''';

  @override
  String get name => kTemplateNameUpdate;

  @override
  Future<void> run() async {
    unawaited(_analyticsService.updateCliEvent());
    if (await _pubService.hasLatestVersion()) return;

    await _processService.runPubGlobalActivate();
  }
}

import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/posthog_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pub_service.dart';

class UpdateCommand extends Command {
  final _analyticsService = locator<PosthogService>();
  final _log = locator<ColorizedLogService>();
  final _processService = locator<ProcessService>();
  final _pubService = locator<PubService>();

  @override
  String get description => '''Updates stacked_cli to latest version.''';

  @override
  String get name => 'update';

  @override
  Future<void> run() async {
    try {
      if (await _pubService.hasLatestVersion()) return;

      await _processService.runPubGlobalActivate();
      await _analyticsService.updateCliEvent();
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

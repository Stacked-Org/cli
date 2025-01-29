import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/commands/compile/compile_command.dart';
import 'package:stacked_cli/src/commands/create/create_command.dart';
import 'package:stacked_cli/src/commands/delete/delete_command.dart';
import 'package:stacked_cli/src/commands/generate/generate_command.dart';
import 'package:stacked_cli/src/commands/update/update_command.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/posthog_service.dart';
import 'package:stacked_cli/src/services/pub_service.dart';

Future<void> main(List<String> arguments) async {
  await setupLocator();

  final runner = CommandRunner(
    'stacked',
    'A command line interface for building and scaffolding stacked apps',
  )
    ..argParser.addFlag(
      ksVersion,
      abbr: 'v',
      negatable: false,
      help: kCommandHelpVersion,
    )
    ..argParser.addFlag(ksDisableVersionCheck,
        negatable: false, help: kCommandHelpDisableVersionCheck)
    // ..argParser.addFlag(
    //   ksEnableAnalytics,
    //   negatable: false,
    //   help: kCommandHelpEnableAnalytics,
    // )
    // ..argParser.addFlag(
    //   ksDisableAnalytics,
    //   negatable: false,
    //   help: kCommandHelpDisableAnalytics,
    // )
    ..addCommand(CreateCommand())
    ..addCommand(DeleteCommand())
    ..addCommand(CompileCommand())
    ..addCommand(GenerateCommand())
    ..addCommand(UpdateCommand());

  try {
    final argResults = runner.parse(arguments);
    await _handleFirstRun();

    if (argResults[ksVersion]) {
      await _handleVersion();
      exit(0);
    }

    /// Disable Analytics until we find how to resolve FileSystemException
    /// triggered twice
    // if (_handleAnalytics(argResults)) exit(0);

    !argResults[ksDisableVersionCheck]
        ? await _notifyNewVersionAvailable(arguments: arguments)
        : {};

    runner.run(arguments);
  } on InvalidStackedStructureException catch (e) {
    stdout.writeln(e.message);
    locator<PosthogService>().logExceptionEvent(
      runtimeType: e.runtimeType.toString(),
      message: e.toString(),
    );
    exit(2);
  } catch (e, s) {
    stdout.writeln(e.toString());
    locator<PosthogService>().logExceptionEvent(
      runtimeType: e.runtimeType.toString(),
      message: e.toString(),
      stackTrace: s.toString(),
    );
    exit(2);
  }
}

/// Prints version of the application.
Future<void> _handleVersion() async {
  stdout.writeln(await locator<PubService>().getCurrentVersion());
}

/// Enables or disables sending of analytics data.
bool _handleAnalytics(ArgResults argResults) {
  if (argResults[ksEnableAnalytics]) {
    locator<PosthogService>().enable(true);
    return true;
  }

  if (argResults[ksDisableAnalytics]) {
    locator<PosthogService>().enable(false);
    return true;
  }

  return false;
}

/// Allows user decide to enable or not analytics on first run.
Future<void> _handleFirstRun() async {
  final analyticsService = locator<PosthogService>();
  if (!analyticsService.isFirstRun) return;

  stdout.writeln('''
  ┌──────────────────────────────────────────────────────────────────┐
  │                   Welcome to the Stacked CLI!                    │
  ├──────────────────────────────────────────────────────────────────┤
  │ We would like to collect anonymous                               │
  │ usage statistics in order to improve the tool.                   │
  │                                                                  │
  │ Would you like to opt-into help us improve?                      │
  └──────────────────────────────────────────────────────────────────┘
  ''');
  stdout.write('[y/n]: ');

  final opt = stdin.readLineSync()?.toLowerCase().trim();
  analyticsService.enable(opt == 'y' || opt == 'yes');
}

/// Notifies new version of Stacked CLI is available
Future<void> _notifyNewVersionAvailable({
  List<String> arguments = const [],
  List<String> ignored = const ['compile', 'update'],
}) async {
  if (arguments.isEmpty) return;

  for (var arg in ignored) {
    if (arguments.first == arg) return;
  }

  if (await locator<PubService>().hasLatestVersion()) return;

  stdout.writeln('''
  ┌──────────────────────────────────────────────────────────────────┐
  │ A new version of Stacked CLI is available!                       │
  │                                                                  │
  │ To update to the latest version, run "stacked update"            │
  └──────────────────────────────────────────────────────────────────┘
  ''');
}

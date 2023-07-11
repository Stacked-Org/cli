import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/commands/delete/delete_dialog_command.dart';
import 'package:stacked_cli/src/commands/delete/delete_service_command.dart';

import 'delete_view_command.dart';

/// A command with subcommands that allows you to delete
/// different parts of the stacked application
class DeleteCommand extends Command {
  @override
  String get description =>
      'Provides access to the different deletion tools we have for stacked.';

  @override
  String get name => 'delete';

  DeleteCommand() {
    addSubcommand(DeleteServiceCommand());
    addSubcommand(DeleteViewCommand());
    addSubcommand(DeleteDialogCommand());
  }
}

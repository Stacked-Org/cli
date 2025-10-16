import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/commands/convert/convert_view_command.dart';

/// Main command for converting existing Stacked resources to different structures
class ConvertCommand extends Command {
  @override
  String get description =>
      'Converts existing Stacked resources to different structures (e.g., making views responsive).';

  @override
  String get name => 'convert';

  ConvertCommand() {
    addSubcommand(ConvertViewCommand());
    addSubcommand(ConvertAppCommand());
  }
}

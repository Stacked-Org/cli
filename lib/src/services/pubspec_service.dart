import 'dart:io';

import 'package:yaml/yaml.dart';

/// Provides functionality to interact with the pubspec in the current project
class PubspecService {
  late YamlMap pubspecYaml;

  /// Reads the pubspec and caches the value locally
  Future<void> initialise({String? workingDirectory}) async {
    final bool hasWorkingDirectory = workingDirectory != null;
    // stdout.writeln('PubspecService - initialise from pubspec.yaml');
    final pubspecYamlContent =
        await File('${hasWorkingDirectory ? '$workingDirectory/' : ''}pubspec.yaml').readAsString();

    pubspecYaml = loadYaml(pubspecYamlContent) as YamlMap;
    // stdout.writeln('PubspecService - initialise complete');
  }

  String get getPackageName => pubspecYaml['name'];
}

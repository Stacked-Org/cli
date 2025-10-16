import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mockito/mockito.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:stacked_cli/src/commands/convert/convert_view_command.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ConvertAppCommand -', () {
    late dynamic logService;
    late dynamic fileService;
    late dynamic processService;
    late dynamic pubspecService;
    late dynamic configService;
    late dynamic analyticsService;

    setUp(() async {
      await setupLocator();
      logService = getAndRegisterColorizedLogService();
      configService = getAndRegisterConfigService();
      fileService = getAndRegisterFileService();
      processService = getAndRegisterProcessService();
      pubspecService = getAndRegisterPubSpecService();
      analyticsService = getAndRegisterPosthogService();

      when(configService.viewPath).thenReturn('ui/views');
      when(configService.stackedAppFilePath).thenReturn('src/locator.dart');
      when(configService.composeAndLoadConfigFile(
        configFilePath: anyNamed('configFilePath'),
        projectPath: anyNamed('projectPath'),
      )).thenAnswer((_) async {});

      when(processService.runFormat(filePath: anyNamed('filePath')))
          .thenAnswer((_) async {});

      when(pubspecService.initialise(
              workingDirectory: anyNamed('workingDirectory')))
          .thenAnswer((_) async {});
      final pubspecYaml = '''
name: test_app
dependencies:
  flutter:
    sdk: flutter
  responsive_builder: ^0.7.1
'''
          .toPubspecYaml();
      when(pubspecService.pubspecYaml).thenReturn(pubspecYaml);

      when(analyticsService.createViewEvent(
        name: anyNamed('name'),
        arguments: anyNamed('arguments'),
      )).thenAnswer((_) async {});
      when(analyticsService.logExceptionEvent(
        runtimeType: anyNamed('runtimeType'),
        message: anyNamed('message'),
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) async {});

      when(fileService.writeStringFile(
        file: anyNamed('file'),
        fileContent: anyNamed('fileContent'),
        verbose: anyNamed('verbose'),
        type: anyNamed('type'),
        verboseMessage: anyNamed('verboseMessage'),
        forceAppend: anyNamed('forceAppend'),
      )).thenAnswer((_) async {});
    });

    tearDown(() {
      locator.reset();
    });

    test('warns when no views are found', () async {
      when(fileService.getFilesInDirectory(
        directoryPath: anyNamed('directoryPath'),
      )).thenAnswer((_) async => <FileSystemEntity>[]);

      final command = ConvertAppCommand();
      final runner = CommandRunner('test', 'test cli')..addCommand(command);

      await runner.run(['app']);

      verify(logService.warn(
        message: kConvertAppNoViewsFound,
      )).called(1);

      verifyNever(processService.runFormat(filePath: anyNamed('filePath')));
    });
  });
}

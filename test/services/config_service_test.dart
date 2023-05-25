import 'package:mockito/mockito.dart';
import 'package:stacked_cli/src/constants/config_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/config_file_not_found_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

ConfigService _getService() => ConfigService();

void main() {
  group('ConfigService -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    const customConfigFilePath = '/Users/filledstacks/Desktop/stacked.json';
    const xdgConfigFilePath =
        '/Users/filledstacks/.config/stacked/stacked.json';
    const stackedAppFilePath = 'src/app/core.dart';
    const testHelpersFilePath = 'lib/src/test/helpers/core_test.helpers.dart';

    const String customConfig = '''
      {
        "stacked_app_file_path": "$stackedAppFilePath",
        "services_path": "my/personal/path/to/services",
        "views_path": "my/personal/path/to/views",
        "test_helpers_file_path": "$testHelpersFilePath",
        "test_services_path": "my/personal/path/to/tests/service",
        "test_views_path": "my/personal/path/to/tests/viewmodel",
        "locator_name": "locator",
        "register_mocks_function": "registerServices",
        "v1": false,
        "line_length": 80
      }
    ''';

    group('resolveConfigFile -', () {
      test('when called with configFilePath should return configFilePath',
          () async {
        getAndRegisterFileService();
        final service = _getService();
        final path = await service.resolveConfigFile(
          configFilePath: customConfigFilePath,
        );
        expect(path, customConfigFilePath);
      });

      test(
          'when called with configFilePath should call fileExists on configFilePath',
          () async {
        final fileService = getAndRegisterFileService();
        final service = _getService();
        await service.resolveConfigFile(configFilePath: customConfigFilePath);
        verify(fileService.fileExists(filePath: customConfigFilePath));
      });

      test(
          'when called with configFilePath and file does NOT exists should throw ConfigFileNotFoundException with message equal kConfigFileNotFoundRetry and shouldHaltCommand equal true',
          () async {
        getAndRegisterFileService(fileExistsResult: false);
        final service = _getService();
        expect(
          () => service.resolveConfigFile(configFilePath: customConfigFilePath),
          throwsA(predicate(
            (e) =>
                e is ConfigFileNotFoundException &&
                e.message == kConfigFileNotFoundRetry &&
                e.shouldHaltCommand == true,
          )),
        );
      });

      test(
          'when called without configFilePath should call fileExists on XDG_CONFIG_HOME',
          () async {
        final fileService = getAndRegisterFileService();
        final service = _getService();
        await service.resolveConfigFile();
        verify(fileService.fileExists(filePath: xdgConfigFilePath));
      });

      test('when called without configFilePath should return xdgConfigFilePath',
          () async {
        getAndRegisterFileService();
        final service = _getService();
        final path = await service.resolveConfigFile();
        expect(path, xdgConfigFilePath);
      });

      test(
        'when called without configFilePath and Home environment variable is not set should throw ConfigFileNotFoundException with message equal kConfigFileNotFound and shouldHaltCommand equal false',
        () async {
          getAndRegisterFileService(throwStateError: true);
          final service = _getService();
          expect(
            () => service.resolveConfigFile(),
            throwsA(predicate(
              (e) =>
                  e is ConfigFileNotFoundException &&
                  e.message == kConfigFileNotFound &&
                  e.shouldHaltCommand == false,
            )),
          );
        },
        skip:
            'Should throw ConfigFileNotFoundException because StateError exception is catched',
      );

      test(
          'when called without configFilePath and file does NOT exists should throw ConfigFileNotFoundException with message equal kConfigFileNotFound and shouldHaltCommand equal false',
          () async {
        getAndRegisterFileService(fileExistsResult: false);
        final service = _getService();
        expect(
          () => service.resolveConfigFile(),
          throwsA(predicate(
            (e) =>
                e is ConfigFileNotFoundException &&
                e.message == kConfigFileNotFound &&
                e.shouldHaltCommand == false,
          )),
        );
      });
    });

    group('composeConfigFile -', () {
      test('when called with configFilePath should return configFilePath',
          () async {
        getAndRegisterFileService();
        final service = _getService();
        final path = await service.composeConfigFile(
          configFilePath: customConfigFilePath,
        );
        expect(path, customConfigFilePath);
      });

      test(
          'when called with configFilePath should call fileExists on configFilePath',
          () async {
        final fileService = getAndRegisterFileService();
        final service = _getService();
        await service.composeConfigFile(configFilePath: customConfigFilePath);
        verify(fileService.fileExists(filePath: customConfigFilePath));
      });

      test(
          'when called with configFilePath and file does NOT exists should throw ConfigFileNotFoundException with message equal kConfigFileNotFoundRetry and shouldHaltCommand equal true',
          () async {
        getAndRegisterFileService(fileExistsResult: false);
        final service = _getService();
        expect(
          () => service.composeConfigFile(configFilePath: customConfigFilePath),
          throwsA(predicate(
            (e) =>
                e is ConfigFileNotFoundException &&
                e.message == kConfigFileNotFoundRetry &&
                e.shouldHaltCommand == true,
          )),
        );
      });

      test('when called without configFilePath should return kConfigFileName',
          () async {
        getAndRegisterFileService();
        final service = _getService();
        final path = await service.composeConfigFile();
        expect(path, kConfigFileName);
      });

      test(
          'when called without configFilePath and projectPath is NOT null should return kConfigFileName with projectPath',
          () async {
        getAndRegisterFileService();
        final projectPath = 'example';
        final service = _getService();
        final path = await service.composeConfigFile(projectPath: projectPath);
        expect(path, '$projectPath/$kConfigFileName');
      });
    });

    group('loadConfig -', () {
      test('when called should call readFileAsString on FileService', () async {
        final fileService = getAndRegisterFileService(readFileResult: '{}');
        final service = _getService();
        await service.loadConfig(customConfigFilePath);
        verify(fileService.readFileAsString(filePath: customConfigFilePath));
      });

      test('when called should set hasCustomConfig as true', () async {
        getAndRegisterFileService(readFileResult: '{}');
        final service = _getService();
        await service.loadConfig(customConfigFilePath);
        expect(service.hasCustomConfig, isTrue);
      });

      test('when called should sanitize path', () async {
        final configToBeSanitize = {"services_path": "lib/services"};
        getAndRegisterFileService(
          readFileResult: configToBeSanitize.toString(),
        );
        final service = _getService();
        await service.loadConfig(customConfigFilePath);
        expect(service.servicePath, 'services');
      });

      test(
          'when called and file not found should throw ConfigFileNotFoundException',
          () async {
        getAndRegisterFileService(throwConfigFileNotFoundException: true);
        final service = _getService();
        expect(
          () => service.loadConfig(customConfigFilePath),
          throwsA(predicate(
            (e) =>
                e is ConfigFileNotFoundException &&
                e.message == kConfigFileNotFoundRetry &&
                e.shouldHaltCommand == true,
          )),
        );
      });

      test('when called and file is malformed should throw FormatException',
          () async {
        getAndRegisterFileService();
        final service = _getService();
        expect(
          () => service.loadConfig(customConfigFilePath),
          throwsA(predicate((e) => e is FormatException)),
        );
      }, skip: 'How can we trigger a FormatException from jsonDecode?');
    });

    group('replaceCustomPaths -', () {
      test('when called without custom config should return same path',
          () async {
        final path = 'test/services/generic_service_test.dart.stk';
        getAndRegisterFileService(readFileResult: '{}');
        final service = _getService();
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, path);
      });

      test('when called with custom config should return custom path',
          () async {
        final path = 'test/services/generic_service_test.dart.stk';
        getAndRegisterFileService(readFileResult: customConfig);
        final service = _getService();
        await service.loadConfig(customConfigFilePath);
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, isNot(path));
        expect(
          customPath,
          'test/my/personal/path/to/services/generic_service_test.dart.stk',
        );
      });

      test(
          'when called with custom stacked app file path should return full stacked_app file path from config',
          () async {
        final path = 'app/app.dart';
        getAndRegisterFileService(readFileResult: customConfig);
        final service = _getService();
        await service.loadConfig(customConfigFilePath);
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, isNot(path));
        expect(customPath, stackedAppFilePath);
      });

      test(
          'when called with custom test_helpers file path should return full test_helpers file path from config',
          () async {
        final path = 'helpers/test_helpers.dart';
        getAndRegisterFileService(readFileResult: customConfig);
        final service = _getService();
        await service.loadConfig(customConfigFilePath);
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, isNot(path));
        expect(customPath, testHelpersFilePath);
      });
    });

    group('sanitizePath -', () {
      test(
          'when called with path equals "lib/src/services" should return "src/services"',
          () async {
        final path = 'lib/src/services';
        final service = _getService();
        final importPath = service.sanitizePath(path);
        expect(importPath, 'src/services');
      });

      test(
          'when called with path equals "src/lib/services" should return "src/lib/services"',
          () async {
        final path = 'src/lib/services';
        final service = _getService();
        final importPath = service.sanitizePath(path);
        expect(importPath, path);
      });

      test(
          'when called with path equals "src/services" should return "src/services"',
          () async {
        final path = 'src/services';
        final service = _getService();
        final importPath = service.sanitizePath(path);
        expect(importPath, path);
      });

      test(
          'when called with path equals "test/services" and find equals "test/" should return "services"',
          () async {
        final path = 'test/services';
        final service = _getService();
        final importPath = service.sanitizePath(path, 'test/');
        expect(importPath, 'services');
      });

      test(
          'when called with path equals "path/to/services" and find equals "test/" should return "path/to/services"',
          () async {
        final path = 'path/to/services';
        final service = _getService();
        final importPath = service.sanitizePath(path, 'test/');
        expect(importPath, path);
      });
    });

    group('getRelativePathToHelpersAndMocks -', () {
      test(
          'when called with path equals "service_tests" should return "../helpers/test_helpers.dart"',
          () async {
        final path = 'service_tests';
        final service = _getService();
        final importPath = service.getFilePathToHelpersAndMocks(path);
        expect(importPath, '../helpers/test_helpers.dart');
      });

      test(
          'when called with path equals "service_test" should return "../helpers/test_helpers.dart"',
          () async {
        final path = 'service_test';
        final service = _getService();
        final importPath = service.getFilePathToHelpersAndMocks(path);
        expect(importPath, '../helpers/test_helpers.dart');
      });

      test(
          'when called with path equals "path/to/service_test" should return "../../../helpers/test_helpers.dart"',
          () async {
        final path = 'path/to/service_test';
        final service = _getService();
        final importPath = service.getFilePathToHelpersAndMocks(path);
        expect(importPath, '../../../helpers/test_helpers.dart');
      });
    });
  });
}

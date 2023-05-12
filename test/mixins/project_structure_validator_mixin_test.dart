import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:test/test.dart';
import '../helpers/test_helpers.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class TestProjectStructureValidator with ProjectStructureValidator {}

Matcher throwsInvalidStackedStructureExceptionWithMessage(
    String expectedMessage) {
  return throwsA(
    predicate((e) =>
        e is InvalidStackedStructureException && e.message == expectedMessage),
  );
}

void main() {
  late TestProjectStructureValidator validator;
  late Directory tempDir;
  late File pubspecFile;
  late File stackedFile;

  setUp(() {
    registerServices();
    validator = TestProjectStructureValidator();
  });
  tearDown(() => locator.reset());

  setUp(() async {
    return Future(() async {
      tempDir =
          await Directory.systemTemp.createTemp('test_project_structure_');
      pubspecFile = File(p.join(tempDir.path, 'pubspec.yaml'));
      final libDir = Directory(p.join(tempDir.path, 'lib'));
      await libDir.create();
      final appDir = Directory(p.join(libDir.path, 'app'));
      await appDir.create();

      stackedFile = File(p.join(appDir.path, 'app.dart'));
    });
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('ProjectStructureValidator', () {
    test('validateStructure: should throw an error if not at project root',
        () async {
      // Arrange
      // Do not create pubspec.yaml file

      // Act
      Future<void> action() async {
        await validator.validateStructure(outputPath: tempDir.path);
      }

      // Assert
      expect(
        action,
        throwsInvalidStackedStructureExceptionWithMessage(
          kInvalidRootDirectory,
        ),
      );
    });

    test(
        'validateStructure: should throw an error if not a stacked application',
        () async {
      // Arrange
      await pubspecFile.create();

      // Act
      Future<void> action() async {
        await validator.validateStructure(outputPath: tempDir.path);
      }

      // Assert
      expect(
        action,
        throwsInvalidStackedStructureExceptionWithMessage(
          kInvalidStackedStructure,
        ),
      );
    });
    test(
        'validateStructure: should not trhow an error if a stacked application and at root',
        () async {
      // Arrange
      await pubspecFile.create();
      await stackedFile.create();

      // Act
      Future<void> action() async {
        await validator.validateStructure(outputPath: tempDir.path);
      }

      // Assert
      await expectLater(action(), completes);
    });
  });
}

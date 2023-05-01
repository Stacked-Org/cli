import 'package:mockito/mockito.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/invalid_arg_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/args_validator_mixin.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:test/test.dart';
import '../helpers/test_helpers.dart';

class TestArgsValidator with ArgsValidator {}

Matcher throwsInvalidArgExceptionWithMessage(String expectedMessage) {
  return throwsA(
    predicate((e) => e is InvalidArgException && e.message == expectedMessage),
  );
}

void main() {
  late TestArgsValidator validator;
  late ColorizedLogService cLogService;

  setUp(() {
    registerServices();
    validator = TestArgsValidator();
    cLogService = locator<ColorizedLogService>();
  });
  tearDown(() => locator.reset());

  group(
    'validateOrganization',
    () {
      test(
        'does not throw an error for a valid organization name',
        () async {
          // Arrange
          final organization = 'com.example';

          // Act
          Future<void> action() async {
            validator.validateOrganization(organization: organization);
          }

          // Assert
          await expectLater(action(), completes);
        },
      );

      test(
        'throws an error for an invalid organization name',
        () {
          // Arrange
          final organization = 'invalid_organization';

          // Act
          Future<void> action() async {
            validator.validateOrganization(organization: organization);
          }

          // Assert
          expect(
            action,
            throwsInvalidArgExceptionWithMessage(
              kInvalidOrganization,
            ),
          );
        },
      );

      test(
        'does not throw an error when organization is null',
        () async {
          // Arrange
          final String? organization = null;

          // Act
          Future<void> action() async {
            validator.validateOrganization(organization: organization);
          }

          // Assert
          await expectLater(action(), completes);
        },
      );
    },
  );

  group(
    'validateAppName',
    () {
      test(
        'does not throw an error for a valid app name',
        () async {
          // Arrange
          final appName = "example_app";

          // Act
          Future<void> action() async {
            validator.validateAppName(appName: appName);
          }

          // Assert
          await expectLater(action(), completes);
        },
      );

      test(
        'throws an error for an invalid app name: containing spaces',
        () {
          // Arrange
          final appName = "example app";

          // Act
          Future<void> action() async {
            validator.validateAppName(appName: appName);
          }

          // Assert
          expect(
            action,
            throwsInvalidArgExceptionWithMessage(
              kInvalidAppName,
            ),
          );
        },
      );

      test(
        'throws an error for an invalid app name: containing upper case letter',
        () {
          // Arrange
          final appName = "eXample_app";

          // Act
          Future<void> action() async {
            validator.validateAppName(appName: appName);
          }

          // Assert
          expect(
            action,
            throwsInvalidArgExceptionWithMessage(
              kInvalidAppName,
            ),
          );
        },
      );
      test(
        'throws an error for an invalid app name: starting with digit',
        () {
          // Arrange
          final appName = "1_example_app";

          // Act
          Future<void> action() async {
            validator.validateAppName(appName: appName);
          }

          // Assert
          expect(
            action,
            throwsInvalidArgExceptionWithMessage(
              kInvalidAppName,
            ),
          );
        },
      );

      test(
        'throws an error for an invalid app name: is reserved word',
        () {
          // Arrange
          final appName = "assert";

          // Act
          Future<void> action() async {
            validator.validateAppName(appName: appName);
          }

          // Assert
          expect(
            action,
            throwsInvalidArgExceptionWithMessage(
              kInvalidAppName,
            ),
          );
        },
      );

      test(
        'does not throw an error when organization is null',
        () {
          validator.validateAppName(appName: null);

          // Verify that the error method is not called on the cLogService
          verifyNever(cLogService.error(
              message:
                  '''App name must contain lower letters and is not allowed to start 
with numbers. Also it can't contain special characters, spaces and 
should be different from dart reserved words.'''));
        },
      );
    },
  );
}

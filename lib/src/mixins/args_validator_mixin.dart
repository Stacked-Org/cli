import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/invalid_arg_exception.dart';

mixin ArgsValidator {
  final organizationPattern = RegExp(r'^[a-z0-9]+(\.[a-z0-9]+)+$');

  bool _isOrganizationValid(String orgName) {
    return organizationPattern.hasMatch(orgName);
  }

  /// Logs an error if the the organization name is invalid
  void validateOrganization({String? organization}) {
    if (organization == null) {
      return;
    }
    if (!_isOrganizationValid(organization)) {
      throw InvalidArgException(kInvalidOrganization);
    }
  }

  final appNamePattern = RegExp(r'^[a-z][a-z0-9_]*(?:_[a-z0-9_]+)*$');

  static const _reservedWords = [
    'assert',
    'break',
    'case',
    'catch',
    'class',
    'const',
    'continue',
    'default',
    'do',
    'else',
    'enum',
    'extends',
    'false',
    'final',
    'finally',
    'for',
    'if',
    'in',
    'is',
    'new',
    'null',
    'rethrow',
    'return',
    'super',
    'switch',
    'this',
    'throw',
    'true',
    'try',
    'var',
    'void',
    'while',
    'with'
  ];

  bool _isValidAppName(String appName) {
    return appNamePattern.hasMatch(appName) &&
        !_reservedWords.contains(appName);
  }

  /// Logs an error if the the app name is invalid
  void validateAppName({String? appName}) {
    if (appName == null) {
      return;
    }
    if (!_isValidAppName(appName)) {
      throw InvalidArgException(kInvalidAppName);
    }
  }
}

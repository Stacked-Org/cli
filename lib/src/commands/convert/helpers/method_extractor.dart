/// Utility class for extracting complete methods from Dart source code.
///
/// This class uses character-by-character parsing with brace/parenthesis counting
/// to accurately extract method definitions that may contain nested structures,
/// arrow functions, and complex expressions.
class MethodExtractor {
  /// Extracts a complete method starting from the given content position.
  ///
  /// Handles both block body methods (`{ ... }`) and arrow function methods (`=> ...;`).
  /// Properly tracks nested braces, parentheses, and arrow functions to ensure
  /// complete method extraction even with deeply nested callbacks.
  ///
  /// Returns `null` if the method cannot be fully extracted.
  ///
  /// Example:
  /// ```dart
  /// final content = '''
  /// @override
  /// void onReady() {
  ///   callback(() {
  ///     print('nested');
  ///   });
  /// }
  /// ''';
  ///
  /// final method = MethodExtractor.extractCompleteMethod(content);
  /// // Returns the complete method including all nested braces
  /// ```
  static String? extractCompleteMethod(String content) {
    int braceCount = 0;
    int parenCount = 0;
    bool foundBody = false;
    bool isArrowFunction = false;
    int endIndex = -1;

    for (int i = 0; i < content.length; i++) {
      final char = content[i];

      if (char == '(') {
        parenCount++;
      } else if (char == ')') {
        parenCount--;
      } else if (_isArrowFunctionStart(content, i, parenCount)) {
        isArrowFunction = true;
        foundBody = true;
        i++; // Skip the '>' character
        continue;
      } else if (char == '{') {
        braceCount++;
        if (!foundBody && parenCount == 0) {
          foundBody = true;
        }
      } else if (char == '}') {
        braceCount--;
        if (foundBody && !isArrowFunction && braceCount == 0) {
          endIndex = i + 1;
          break;
        }
      } else if (char == ';' &&
          foundBody &&
          isArrowFunction &&
          parenCount == 0) {
        endIndex = i + 1;
        break;
      }
    }

    if (endIndex != -1) {
      return content.substring(0, endIndex).trim();
    }

    return null;
  }

  /// Checks if the current position marks the start of an arrow function (=>).
  static bool _isArrowFunctionStart(String content, int index, int parenCount) {
    return parenCount == 0 &&
        index < content.length - 1 &&
        content[index] == '=' &&
        content[index + 1] == '>';
  }
}

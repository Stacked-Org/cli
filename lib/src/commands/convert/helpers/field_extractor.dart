/// Utility class for extracting field declarations from Dart class definitions.
///
/// Handles various field declaration patterns including:
/// - Fields with initialization: `final x = SomeClass();`
/// - Fields without initialization: `final Type field;`
/// - Fields before constructors
/// - Fields after constructors
/// - Nullable fields: `final int? value;`
class FieldExtractor {
  /// Extracts field declarations from a StackedView class definition.
  ///
  /// Only extracts fields from the main class body, not from:
  /// - Constructors
  /// - Inner/helper classes
  /// - Methods
  ///
  /// The extraction stops at the first `@override` method to avoid including
  /// fields from nested classes or method bodies.
  ///
  /// Returns a newline-separated string of field declarations, or empty string
  /// if no fields are found.
  ///
  /// Example:
  /// ```dart
  /// final content = '''
  /// class MyView extends StackedView<MyViewModel> {
  ///   final Course course;
  ///   final bool isEnabled;
  ///
  ///   MyView({required this.course, this.isEnabled = true});
  ///
  ///   @override
  ///   Widget builder(...) { ... }
  /// }
  /// ''';
  ///
  /// final fields = FieldExtractor.extractFieldDeclarations(content);
  /// // Returns: "final Course course;\nfinal bool isEnabled;"
  /// ```
  static String extractFieldDeclarations(String originalContent) {
    final classBodyStart = _findClassBodyStart(originalContent);
    if (classBodyStart == -1) return '';

    final firstOverrideIndex =
        _findFirstOverrideIndex(originalContent, classBodyStart);
    if (firstOverrideIndex == -1) return '';

    final fieldsSection = originalContent
        .substring(classBodyStart, classBodyStart + firstOverrideIndex)
        .trim();

    final fields = <String>[];
    fields.addAll(_extractFieldsWithInitialization(fieldsSection));
    fields.addAll(_extractFieldsWithoutInitialization(fieldsSection));

    return fields.join('\n  ');
  }

  /// Finds the starting index of the class body (after the opening brace).
  static int _findClassBodyStart(String content) {
    final classPattern = RegExp(
      r'class\s+\w+\s+extends\s+StackedView<\w+>(?:\s+with\s+[\w\s,\$]+)?\s*\{',
      multiLine: true,
    );
    final classMatch = classPattern.firstMatch(content);
    return classMatch?.end ?? -1;
  }

  /// Finds the index of the first @override annotation relative to class body start.
  static int _findFirstOverrideIndex(String content, int classBodyStart) {
    final contentAfterClass = content.substring(classBodyStart);
    final firstOverridePattern = RegExp(r'@override', multiLine: true);
    final match = firstOverridePattern.firstMatch(contentAfterClass);
    return match?.start ?? -1;
  }

  /// Extracts fields that have initialization (e.g., `final x = value;`).
  static List<String> _extractFieldsWithInitialization(String fieldsSection) {
    final fieldWithInitPattern = RegExp(
      r'^\s*((?:final\s+)?(?:[\w<>?,\s]+)\s+\w+\s*=\s*[^;]+;)',
      multiLine: true,
    );

    final fields = <String>[];
    for (final match in fieldWithInitPattern.allMatches(fieldsSection)) {
      final field = match.group(1)?.trim() ?? '';
      if (field.isNotEmpty && _isValidFieldDeclaration(field)) {
        fields.add(field);
      }
    }

    return fields;
  }

  /// Extracts fields without initialization (e.g., `final Type field;`).
  static List<String> _extractFieldsWithoutInitialization(
      String fieldsSection) {
    final fieldWithoutInitPattern = RegExp(
      r'^\s*(final\s+[\w<>?,\s]+\s+\w+;)',
      multiLine: true,
    );

    final fields = <String>[];
    for (final match in fieldWithoutInitPattern.allMatches(fieldsSection)) {
      final field = match.group(1)?.trim() ?? '';
      if (field.isNotEmpty &&
          !field.contains('(') &&
          !field.startsWith('const ') &&
          !field.startsWith('factory ')) {
        fields.add(field);
      }
    }

    return fields;
  }

  /// Validates that a field declaration is not actually a constructor or factory.
  ///
  /// A line is a constructor if it has a `(` before any `=` sign.
  /// For example:
  /// - Constructor: `MyView({super.key})` - paren before any equals
  /// - Field: `final x = MyClass()` - equals before paren
  static bool _isValidFieldDeclaration(String field) {
    if (field.startsWith('const ') || field.startsWith('factory ')) {
      return false;
    }

    final equalsIndex = field.indexOf('=');
    final parenIndex = field.indexOf('(');

    // If there's a paren before the equals sign (or no equals at all),
    // this is likely a constructor, not a field
    final isConstructor =
        parenIndex != -1 && (equalsIndex == -1 || parenIndex < equalsIndex);

    return !isConstructor;
  }
}

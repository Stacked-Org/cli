/// Utility class for extracting class annotations and mixins from Dart code.
///
/// Handles:
/// - Single-line annotations: `@override`
/// - Multi-line annotations with nested parentheses: `@FormView(fields: [...])`
/// - Class mixins: `with $MyMixin, AnotherMixin`
class AnnotationExtractor {
  /// Extracts all annotations for a given class declaration.
  ///
  /// Supports multi-line annotations with proper parenthesis depth tracking.
  /// Works backwards from the class declaration to find all associated annotations.
  ///
  /// Returns a string containing all annotations (with proper formatting),
  /// or an empty string if no annotations are found.
  ///
  /// Example:
  /// ```dart
  /// final content = '''
  /// @FormView(
  ///   fields: [
  ///     FormTextField(name: 'email'),
  ///   ],
  /// )
  /// class MyView extends StackedView<MyViewModel> { ... }
  /// ''';
  ///
  /// final annotations = AnnotationExtractor.extractClassAnnotations(content, 'MyView');
  /// // Returns the full @FormView(...) annotation
  /// ```
  static String extractClassAnnotations(
      String originalContent, String className) {
    final classIndex = _findClassDeclaration(originalContent, className);
    if (classIndex == -1) return '';

    final beforeClass = originalContent.substring(0, classIndex);
    final lines = beforeClass.split('\n');

    return _extractAnnotationLines(lines);
  }

  /// Extracts mixin declarations from a class definition.
  ///
  /// Example:
  /// ```dart
  /// class MyView extends StackedView<MyViewModel> with $MyForm, OtherMixin {
  /// ```
  /// Returns: `$MyForm, OtherMixin`
  static String extractClassMixins(String originalContent, String className) {
    final mixinPattern = RegExp(
      r'class\s+' +
          RegExp.escape(className) +
          r'\s+extends\s+[\w<>]+\s+with\s+([\w\s,\$]+?)(?:\s+implements|\s*\{)',
      multiLine: true,
    );

    final match = mixinPattern.firstMatch(originalContent);
    return match?.group(1)?.trim() ?? '';
  }

  /// Finds the starting index of a class declaration.
  static int _findClassDeclaration(String content, String className) {
    final classPattern = RegExp(
      r'class\s+' + RegExp.escape(className) + r'\s+extends',
      multiLine: true,
    );
    final classMatch = classPattern.firstMatch(content);
    return classMatch?.start ?? -1;
  }

  /// Extracts annotation lines by working backwards from the class declaration.
  ///
  /// Uses parenthesis depth tracking to handle multi-line annotations properly.
  static String _extractAnnotationLines(List<String> lines) {
    final annotationLines = <String>[];
    int parenDepth = 0;
    bool inAnnotation = false;

    // Start from the end (just before class) and work backwards
    for (int i = lines.length - 1; i >= 0; i--) {
      final line = lines[i];
      final trimmed = line.trim();

      // Count parentheses to track multi-line annotations
      for (int j = trimmed.length - 1; j >= 0; j--) {
        if (trimmed[j] == ')') parenDepth++;
        if (trimmed[j] == '(') parenDepth--;
      }

      // Check if this line is part of an annotation
      if (trimmed.startsWith('@') || inAnnotation || parenDepth > 0) {
        annotationLines.insert(0, line);
        inAnnotation = parenDepth > 0 || trimmed.startsWith('@');
      } else if (trimmed.isEmpty || trimmed.startsWith('//')) {
        // Keep empty lines and comments that are part of annotation block
        if (annotationLines.isNotEmpty) {
          annotationLines.insert(0, line);
        }
      } else {
        // Hit non-annotation code, stop searching
        break;
      }
    }

    // Remove leading empty lines
    while (annotationLines.isNotEmpty && annotationLines.first.trim().isEmpty) {
      annotationLines.removeAt(0);
    }

    return annotationLines.join('\n');
  }
}

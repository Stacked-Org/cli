import 'package:stacked_cli/src/commands/convert/helpers/annotation_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('AnnotationExtractor -', () {
    group('extractClassAnnotations -', () {
      test('should extract single-line annotation', () {
        const content = '''
@override
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassAnnotations(content, 'MyView');

        expect(result, equals('@override'));
      });

      test('should extract multi-line @FormView annotation', () {
        const content = '''
@FormView(
  fields: [
    FormTextField(
      name: 'handicap',
      validator: FormValidators.validateHandicap,
    ),
  ],
)
class AddUserInformationView extends StackedView<AddUserInformationViewModel> {
  const AddUserInformationView({super.key});
}
''';

        final result = AnnotationExtractor.extractClassAnnotations(
            content, 'AddUserInformationView');

        expect(result, contains('@FormView('));
        expect(result, contains('fields: ['));
        expect(result, contains('FormTextField('));
        expect(result, contains('validateHandicap'));
      });

      test('should extract annotation with deeply nested parentheses', () {
        const content = '''
@ComplexAnnotation(
  field1: NestedClass(
    subField: AnotherClass(
      deepField: [
        Item(value: 1),
        Item(value: 2),
      ],
    ),
  ),
)
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassAnnotations(content, 'MyView');

        expect(result, contains('@ComplexAnnotation('));
        expect(result, contains('NestedClass('));
        expect(result, contains('AnotherClass('));
        expect(result, contains('deepField: ['));

        // Verify parentheses are balanced
        final openParens = '('.allMatches(result).length;
        final closeParens = ')'.allMatches(result).length;
        expect(openParens, equals(closeParens));
      });

      test('should extract multiple annotations', () {
        const content = '''
@deprecated
@FormView(
  fields: [
    FormTextField(name: 'email'),
  ],
)
@immutable
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassAnnotations(content, 'MyView');

        expect(result, contains('@deprecated'));
        expect(result, contains('@FormView('));
        expect(result, contains('@immutable'));
      });

      test('should return empty string when no annotations exist', () {
        const content = '''
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassAnnotations(content, 'MyView');

        expect(result, isEmpty);
      });

      test('should handle annotations with comments', () {
        const content = '''
// This is a form view
@FormView(
  // Email field
  fields: [
    FormTextField(name: 'email'),
  ],
)
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassAnnotations(content, 'MyView');

        expect(result, contains('// This is a form view'));
        expect(result, contains('// Email field'));
        expect(result, contains('@FormView('));
      });

      test('should not include code before annotations', () {
        const content = '''
import 'package:flutter/material.dart';

final someVariable = 'value';

@FormView(fields: [])
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassAnnotations(content, 'MyView');

        expect(result, isNot(contains('import')));
        expect(result, isNot(contains('someVariable')));
        expect(result, contains('@FormView'));
      });

      test('should return empty string for non-existent class', () {
        const content = '''
@override
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});
}
''';

        final result = AnnotationExtractor.extractClassAnnotations(
            content, 'NonExistentView');

        expect(result, isEmpty);
      });
    });

    group('extractClassMixins -', () {
      test('should extract single mixin', () {
        const content = '''
class AddUserInformationView extends StackedView<AddUserInformationViewModel>
    with \$AddUserInformationView {
  const AddUserInformationView({super.key});
}
''';

        final result = AnnotationExtractor.extractClassMixins(
            content, 'AddUserInformationView');

        expect(result, equals('\$AddUserInformationView'));
      });

      test('should extract multiple mixins', () {
        const content = '''
class MyView extends StackedView<MyViewModel>
    with \$MyFormView, FormStateMixin, ValidatorMixin {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassMixins(content, 'MyView');

        expect(result, equals('\$MyFormView, FormStateMixin, ValidatorMixin'));
      });

      test('should return empty string when no mixins exist', () {
        const content = '''
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassMixins(content, 'MyView');

        expect(result, isEmpty);
      });

      test('should handle mixins with implements clause', () {
        const content = '''
class MyView extends StackedView<MyViewModel>
    with \$MyFormView implements MyInterface {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassMixins(content, 'MyView');

        expect(result, equals('\$MyFormView'));
        expect(result, isNot(contains('implements')));
        expect(result, isNot(contains('MyInterface')));
      });

      test('should handle mixins with multiline formatting', () {
        const content = '''
class MyView extends StackedView<MyViewModel>
    with
        \$MyFormView,
        ValidatorMixin,
        StateMixin {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassMixins(content, 'MyView');

        expect(result, contains('\$MyFormView'));
        expect(result, contains('ValidatorMixin'));
        expect(result, contains('StateMixin'));
      });

      test('should return empty string for non-existent class', () {
        const content = '''
class MyView extends StackedView<MyViewModel> with \$MyFormView {
  const MyView({super.key});
}
''';

        final result =
            AnnotationExtractor.extractClassMixins(content, 'NonExistentView');

        expect(result, isEmpty);
      });
    });
  });
}

import 'package:stacked_cli/src/commands/convert/helpers/field_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('FieldExtractor -', () {
    group('extractFieldDeclarations -', () {
      test('should extract fields without initialization', () {
        const content = '''
class CourseDetailsView extends StackedView<CourseDetailsViewModel> {
  final Course course;
  final bool skipCourseScorecard;

  const CourseDetailsView({
    super.key,
    required this.course,
    this.skipCourseScorecard = true,
  });

  @override
  Widget builder(BuildContext context, CourseDetailsViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, contains('final Course course;'));
        expect(result, contains('final bool skipCourseScorecard;'));
      });

      test('should extract fields with initialization', () {
        const content = '''
class OneTimePasswordVerificationView extends StackedView<OneTimePasswordVerificationViewModel> {
  OneTimePasswordVerificationView({super.key});

  final pinputFocusNode = FocusNode();

  @override
  Widget builder(BuildContext context, OneTimePasswordVerificationViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, contains('final pinputFocusNode = FocusNode();'));
      });

      test('should not extract constructor as field', () {
        const content = '''
class MyView extends StackedView<MyViewModel> {
  MyView({super.key});

  @override
  Widget builder(BuildContext context, MyViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, isNot(contains('MyView(')));
        expect(result, isEmpty);
      });

      test('should not extract fields from inner classes', () {
        const content = '''
class GameSettingsView extends StackedView<GameSettingsViewModel> {
  const GameSettingsView({super.key});

  @override
  Widget builder(BuildContext context, GameSettingsViewModel viewModel, Widget? child) {
    return Container();
  }
}

class _StablefordPointIndicator extends StatelessWidget {
  final int points;
  final int relativeToPar;

  const _StablefordPointIndicator({
    required this.points,
    required this.relativeToPar,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Points: \$points');
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        // Should not include fields from _StablefordPointIndicator
        expect(result, isNot(contains('final int points')));
        expect(result, isNot(contains('final int relativeToPar')));
      });

      test('should handle nullable fields', () {
        const content = '''
class CourseListView extends StackedView<CourseListViewModel> {
  final int? stateId;
  final String? categoryName;

  const CourseListView({super.key, this.stateId, this.categoryName});

  @override
  Widget builder(BuildContext context, CourseListViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, contains('final int? stateId;'));
        expect(result, contains('final String? categoryName;'));
      });

      test('should handle generic type fields', () {
        const content = '''
class MyView extends StackedView<MyViewModel> {
  final List<String> items;
  final Map<String, dynamic> data;

  const MyView({super.key, required this.items, required this.data});

  @override
  Widget builder(BuildContext context, MyViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, contains('final List<String> items;'));
        expect(result, contains('final Map<String, dynamic> data;'));
      });

      test('should not extract const constructors', () {
        const content = '''
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});

  @override
  Widget builder(BuildContext context, MyViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, isNot(contains('const MyView')));
        expect(result, isEmpty);
      });

      test('should not extract factory constructors', () {
        const content = '''
class MyView extends StackedView<MyViewModel> {
  factory MyView.create() => MyView();

  MyView({super.key});

  @override
  Widget builder(BuildContext context, MyViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, isNot(contains('factory')));
      });

      test('should handle fields with complex initialization', () {
        const content = '''
class MyView extends StackedView<MyViewModel> {
  final controller = TextEditingController(text: 'initial value');
  final notifier = ValueNotifier<int>(0);

  MyView({super.key});

  @override
  Widget builder(BuildContext context, MyViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(
            result,
            contains(
                "final controller = TextEditingController(text: 'initial value');"));
        expect(result, contains('final notifier = ValueNotifier<int>(0);'));
      });

      test('should return empty string when no fields exist', () {
        const content = '''
class MyView extends StackedView<MyViewModel> {
  const MyView({super.key});

  @override
  Widget builder(BuildContext context, MyViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, isEmpty);
      });

      test('should return empty string for invalid class structure', () {
        const content = '''
class MyClass {
  final String name;
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, isEmpty);
      });

      test('should handle views with mixins', () {
        const content = '''
class AddUserInformationView extends StackedView<AddUserInformationViewModel>
    with \$AddUserInformationView {
  final int startingIndex;

  const AddUserInformationView({
    super.key,
    required this.startingIndex,
  });

  @override
  Widget builder(BuildContext context, AddUserInformationViewModel viewModel, Widget? child) {
    return Container();
  }
}
''';

        final result = FieldExtractor.extractFieldDeclarations(content);

        expect(result, contains('final int startingIndex;'));
      });
    });
  });
}

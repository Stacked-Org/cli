import 'package:stacked_cli/src/commands/convert/helpers/method_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('MethodExtractor -', () {
    group('extractCompleteMethod -', () {
      test('should extract simple block body method', () {
        const content = '''
@override
void onReady() {
  print('ready');
}
''';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNotNull);
        expect(result, contains('@override'));
        expect(result, contains('void onReady()'));
        expect(result, contains("print('ready');"));
        expect(result!.trim().endsWith('}'), isTrue);
      });

      test('should extract arrow function method', () {
        const content = '''
@override
HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
''';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNotNull);
        expect(result, contains('@override'));
        expect(result, contains('viewModelBuilder'));
        expect(result, contains('=> HomeViewModel()'));
        expect(result!.trim().endsWith(';'), isTrue);
      });

      test('should extract arrow function with nested callbacks', () {
        const content = '''
@override
CourseDetailsViewModel viewModelBuilder(BuildContext context) =>
    CourseDetailsViewModel(
      course: course,
      onShowTutorial: () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          HotspotProvider.of(context).startFlow(HotspotKey.courseDetails);
        });
      },
    );
''';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNotNull);
        expect(result, contains('onShowTutorial'));
        expect(result, contains('addPostFrameCallback'));
        expect(result, contains('HotspotProvider'));

        // Verify braces are balanced
        final openBraces = '{'.allMatches(result!).length;
        final closeBraces = '}'.allMatches(result).length;
        expect(openBraces, equals(closeBraces));

        // Verify parentheses are balanced
        final openParens = '('.allMatches(result).length;
        final closeParens = ')'.allMatches(result).length;
        expect(openParens, equals(closeParens));
      });

      test('should extract method with deeply nested structures', () {
        const content = '''
@override
Widget builder(BuildContext context, ViewModel viewModel, Widget? child) {
  return Container(
    child: Column(
      children: [
        Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      title: Text('Nested'),
                    );
                  },
                );
              },
              child: Text('Tap me'),
            );
          },
        ),
      ],
    ),
  );
}
''';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNotNull);
        expect(result, contains('showDialog'));
        expect(result, contains('AlertDialog'));

        // Verify structure is balanced
        final openBraces = '{'.allMatches(result!).length;
        final closeBraces = '}'.allMatches(result).length;
        expect(openBraces, equals(closeBraces));
      });

      test('should handle method without @override', () {
        const content = '''
CourseDetailsViewModel viewModelBuilder(BuildContext context) =>
    CourseDetailsViewModel(
      course: course,
      onShowTutorial: () {
        print('tutorial');
      },
    );
''';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNotNull);
        expect(result, contains('viewModelBuilder'));
        expect(result, contains('onShowTutorial'));
      });

      test('should return null for incomplete method', () {
        const content = '''
@override
void incomplete(
''';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNull);
      });

      test('should handle method with map literals', () {
        const content = '''
@override
Map<String, dynamic> getData() {
  return {
    'name': 'test',
    'nested': {
      'value': 123,
    },
  };
}
''';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNotNull);
        expect(result, contains("'name': 'test'"));
        expect(result, contains("'nested'"));

        final openBraces = '{'.allMatches(result!).length;
        final closeBraces = '}'.allMatches(result).length;
        expect(openBraces, equals(closeBraces));
      });

      test('should handle arrow function with single line', () {
        const content = '@override String get name => "John Doe";';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNotNull);
        expect(result, equals('@override String get name => "John Doe";'));
      });

      test('should handle method with string containing braces', () {
        const content = '''
@override
void test() {
  print('This { has } braces');
  final code = 'if (x) { return; }';
}
''';

        final result = MethodExtractor.extractCompleteMethod(content);

        expect(result, isNotNull);
        expect(result, contains('This { has } braces'));
        expect(result, contains('if (x) { return; }'));
      });
    });
  });
}

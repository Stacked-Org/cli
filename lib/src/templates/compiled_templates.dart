/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.


// -------- SettingsJsonStk Template Data ----------

const String kAppMobileTemplateSettingsJsonStkPath =
    '.vscode/settings.json.stk';

const String kAppMobileTemplateSettingsJsonStkContent = '''
{
    "explorer.fileNesting.enabled": true,
    "explorer.fileNesting.patterns": {
        "*.dart": "\${capture}.mobile.dart, \${capture}.tablet.dart, \${capture}.desktop.dart, \${capture}.form.dart, \${capture}.g.dart, \${capture}.freezed.dart, \${capture}.logger.dart, \${capture}.locator.dart, \${capture}.router.dart, \${capture}.dialogs.dart, \${capture}.bottomsheets.dart"
    }
}

''';

// --------------------------------------------------


// -------- App Template Data ----------

const String kAppMobileTemplateAppPath =
    'lib/app/app.dart.stk';

const String kAppMobileTemplateAppContent = '''
import 'package:{{packageName}}/{{{bottomSheetsPath}}}/notice/notice_sheet.dart';
import 'package:{{packageName}}/{{{dialogsPath}}}/info_alert/info_alert_dialog.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_view.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

''';

// --------------------------------------------------


// -------- Main Template Data ----------

const String kAppMobileTemplateMainPath =
    'lib/main.dart.stk';

const String kAppMobileTemplateMainContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeDialogFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/{{{relativeRouterFilePath}}}';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}

''';

// --------------------------------------------------


// -------- NoticeSheet Template Data ----------

const String kAppMobileTemplateNoticeSheetPath =
    'lib/ui/bottom_sheets/notice/notice_sheet.dart.stk';

const String kAppMobileTemplateNoticeSheetContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'notice_sheet_model.dart';

class NoticeSheet extends StackedView<NoticeSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;
  const NoticeSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NoticeSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceTiny,
          Text(
            request.description!,
            style: const TextStyle(fontSize: 14, color: kcMediumGrey),
            maxLines: 3,
            softWrap: true,
          ),
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  NoticeSheetModel viewModelBuilder(BuildContext context) =>
      NoticeSheetModel();
}

''';

// --------------------------------------------------


// -------- NoticeSheetModel Template Data ----------

const String kAppMobileTemplateNoticeSheetModelPath =
    'lib/ui/bottom_sheets/notice/notice_sheet_model.dart.stk';

const String kAppMobileTemplateNoticeSheetModelContent = '''
import 'package:stacked/stacked.dart';

class NoticeSheetModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- AppColors Template Data ----------

const String kAppMobileTemplateAppColorsPath =
    'lib/ui/common/app_colors.dart.stk';

const String kAppMobileTemplateAppColorsContent = '''
import 'package:flutter/material.dart';

const Color kcPrimaryColor = Color(0xFF9600FF);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcBackgroundColor = kcDarkGreyColor;

''';

// --------------------------------------------------


// -------- AppStrings Template Data ----------

const String kAppMobileTemplateAppStringsPath =
    'lib/ui/common/app_strings.dart.stk';

const String kAppMobileTemplateAppStringsContent = '''
const String ksHomeBottomSheetTitle = 'Build Great Apps!';
const String ksHomeBottomSheetDescription =
    'Stacked is built to help you build better apps. Give us a chance and we\\'ll prove it to you. Check out stacked.filledstacks.com to learn more';

''';

// --------------------------------------------------


// -------- UiHelpers Template Data ----------

const String kAppMobileTemplateUiHelpersPath =
    'lib/ui/common/ui_helpers.dart.stk';

const String kAppMobileTemplateUiHelpersContent = '''
import 'dart:math';

import 'package:flutter/material.dart';

const double _tinySize = 5.0;
const double _smallSize = 10.0;
const double _mediumSize = 25.0;
const double _largeSize = 50.0;
const double _massiveSize = 120.0;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

Widget spacedDivider = const Column(
  children: <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);
double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 15);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(BuildContext context,
    {double? fontSize, double? max}) {
  max ??= 100;

  var responsiveSize = min(
      screenWidthFraction(context, dividedBy: 10) * ((fontSize ?? 100) / 100),
      max);
  
  return responsiveSize;
}

''';

// --------------------------------------------------


// -------- InfoAlertDialog Template Data ----------

const String kAppMobileTemplateInfoAlertDialogPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog.dart.stk';

const String kAppMobileTemplateInfoAlertDialogContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'info_alert_dialog_model.dart';

const double _graphicSize = 60;

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      verticalSpaceTiny,
                      Text(
                        request.description!,
                        style:
                            const TextStyle(fontSize: 14, color: kcMediumGrey),
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xffF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '⭐️',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(
                confirmed: true,
              )),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}

''';

// --------------------------------------------------


// -------- InfoAlertDialogModel Template Data ----------

const String kAppMobileTemplateInfoAlertDialogModelPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog_model.dart.stk';

const String kAppMobileTemplateInfoAlertDialogModelContent = '''
import 'package:stacked/stacked.dart';

class InfoAlertDialogModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- HomeView Template Data ----------

const String kAppMobileTemplateHomeViewPath =
    'lib/ui/views/home/home_view.dart.stk';

const String kAppMobileTemplateHomeViewContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    const Text(
                      'Hello, STACKED!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceMedium,
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.incrementCounter,
                      child: Text(
                        viewModel.counterLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      onPressed: viewModel.showDialog,
                      child: const Text(
                        'Show Dialog',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      onPressed: viewModel.showBottomSheet,
                      child: const Text(
                        'Show Bottom Sheet',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) => HomeViewModel();
}

''';

// --------------------------------------------------


// -------- HomeViewmodel Template Data ----------

const String kAppMobileTemplateHomeViewmodelPath =
    'lib/ui/views/home/home_viewmodel.dart.stk';

const String kAppMobileTemplateHomeViewmodelContent = '''
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeDialogFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: \$_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked \$_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}

''';

// --------------------------------------------------


// -------- HomeViewV1 Template Data ----------

const String kAppMobileTemplateHomeViewV1Path =
    'lib/ui/views/home/home_view_v1.dart.stk';

const String kAppMobileTemplateHomeViewV1Content = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  verticalSpaceLarge,
                  Column(
                    children: [
                      const Text(
                        'Hello, STACKED!',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      verticalSpaceMedium,
                      MaterialButton(
                        color: Colors.black,
                        onPressed: model.incrementCounter,
                        child: Text(
                          model.counterLabel,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: kcDarkGreyColor,
                        child: const Text(
                          'Show Dialog',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: model.showDialog,
                      ),
                      MaterialButton(
                        color: kcDarkGreyColor,
                        child: const Text(
                          'Show Bottom Sheet',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: model.showBottomSheet,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';

// --------------------------------------------------


// -------- StartupView Template Data ----------

const String kAppMobileTemplateStartupViewPath =
    'lib/ui/views/startup/startup_view.dart.stk';

const String kAppMobileTemplateStartupViewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'STACKED',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Loading ...', style: TextStyle(fontSize: 16)),
                horizontalSpaceSmall,
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 6,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

''';

// --------------------------------------------------


// -------- StartupViewmodel Template Data ----------

const String kAppMobileTemplateStartupViewmodelPath =
    'lib/ui/views/startup/startup_viewmodel.dart.stk';

const String kAppMobileTemplateStartupViewmodelContent = '''
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/{{{relativeRouterFilePath}}}';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    _navigationService.replaceWithHomeView();
  }
}

''';

// --------------------------------------------------


// -------- StartupViewV1 Template Data ----------

const String kAppMobileTemplateStartupViewV1Path =
    'lib/ui/views/startup/startup_view_v1.dart.stk';

const String kAppMobileTemplateStartupViewV1Content = '''
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'STACKED',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Loading ...',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  horizontalSpaceSmall,
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 6,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => model.runStartupLogic()),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
''';

// --------------------------------------------------


// -------- PubspecYamlStk Template Data ----------

const String kAppMobileTemplatePubspecYamlStkPath =
    'pubspec.yaml.stk';

const String kAppMobileTemplatePubspecYamlStkContent = '''
name: {{packageName}}
description: {{packageDescription}}
publish_to: 'none'
version: 0.1.0

environment:
  sdk: '>=3.0.3 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  stacked: ^3.4.0
  stacked_services: ^1.1.0

dev_dependencies:
  build_runner: ^2.4.5
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  mockito: ^5.4.1
  stacked_generator: ^1.3.3

flutter:
  uses-material-design: true

''';

// --------------------------------------------------


// -------- READMEMdStk Template Data ----------

const String kAppMobileTemplateREADMEMdStkPath =
    'README.md.stk';

const String kAppMobileTemplateREADMEMdStkContent = '''
# {{packageName}}

{{packageDescription}}
''';

// --------------------------------------------------


// -------- StackedJsonStk Template Data ----------

const String kAppMobileTemplateStackedJsonStkPath =
    'stacked.json.stk';

const String kAppMobileTemplateStackedJsonStkContent = '''
{
    "bottom_sheets_path": "ui/bottom_sheets",
    "dialogs_path": "ui/dialogs",
    "line_length": 80,
    "locator_name": "locator",
    "prefer_web": false,
    "register_mocks_function": "registerServices",
    "services_path": "services",
    "stacked_app_file_path": "app/app.dart",
    "test_helpers_file_path": "helpers/test_helpers.dart",
    "test_services_path": "services",
    "test_views_path": "viewmodels",
    "test_widgets_path": "widget_models",
    "v1": false,
    "views_path": "ui/views",
    "widgets_path": "ui/widgets/common"
}
''';

// --------------------------------------------------


// -------- TestHelpers Template Data ----------

const String kAppMobileTemplateTestHelpersPath =
    'test/helpers/test_helpers.dart.stk';

const String kAppMobileTemplateTestHelpersContent = '''
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  // @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  // @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

''';

// --------------------------------------------------


// -------- HomeViewmodelTest Template Data ----------

const String kAppMobileTemplateHomeViewmodelTestPath =
    'test/viewmodels/home_viewmodel_test.dart.stk';

const String kAppMobileTemplateHomeViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_viewmodel.dart';

import '{{{viewTestHelpersImport}}}';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('incrementCounter -', () {
      test('When called once should return  Counter is: 1', () {
        final model = getModel();
        model.incrementCounter();
        expect(model.counterLabel, 'Counter is: 1');
      });
    });

    group('showBottomSheet -', () {
      test('When called, should show custom bottom sheet using notice variant',
          () {
        final bottomSheetService = getAndRegisterBottomSheetService();

        final model = getModel();
        model.showBottomSheet();
        verify(bottomSheetService.showCustomSheet(
          variant: BottomSheetType.notice,
          title: ksHomeBottomSheetTitle,
          description: ksHomeBottomSheetDescription,
        ));
      });
    });
  });
}

''';

// --------------------------------------------------


// -------- InfoAlertDialogModelTest Template Data ----------

const String kAppMobileTemplateInfoAlertDialogModelTestPath =
    'test/viewmodels/info_alert_dialog_model_test.dart.stk';

const String kAppMobileTemplateInfoAlertDialogModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- NoticeSheetModelTest Template Data ----------

const String kAppMobileTemplateNoticeSheetModelTestPath =
    'test/viewmodels/notice_sheet_model_test.dart.stk';

const String kAppMobileTemplateNoticeSheetModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- SettingsJsonStk Template Data ----------

const String kAppWebTemplateSettingsJsonStkPath =
    '.vscode/settings.json.stk';

const String kAppWebTemplateSettingsJsonStkContent = '''
{
    "explorer.fileNesting.enabled": true,
    "explorer.fileNesting.patterns": {
        "*.dart": "\${capture}.mobile.dart, \${capture}.tablet.dart, \${capture}.desktop.dart, \${capture}.form.dart, \${capture}.g.dart, \${capture}.freezed.dart, \${capture}.logger.dart, \${capture}.locator.dart, \${capture}.router.dart, \${capture}.dialogs.dart, \${capture}.bottomsheets.dart"
    }
}

''';

// --------------------------------------------------


// -------- BuildYamlStk Template Data ----------

const String kAppWebTemplateBuildYamlStkPath =
    'build.yaml.stk';

const String kAppWebTemplateBuildYamlStkContent = '''
targets:
  \$default:
    builders:
      stacked_generator|stackedRouterGenerator:
        options:
          navigator2: true
''';

// --------------------------------------------------


// -------- App Template Data ----------

const String kAppWebTemplateAppPath =
    'lib/app/app.dart.stk';

const String kAppWebTemplateAppContent = '''
import 'package:{{packageName}}/{{{bottomSheetsPath}}}/notice/notice_sheet.dart';
import 'package:{{packageName}}/{{{dialogsPath}}}/info_alert/info_alert_dialog.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_view.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/startup/startup_view.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/unknown/unknown_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(page: StartupView, initial: true),
    CustomRoute(page: HomeView),
    // @stacked-route

    CustomRoute(page: UnknownView, path: '/404'),

    /// When none of the above routes match, redirect to UnknownView
    RedirectRoute(path: '*', redirectTo: '/404'),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: RouterService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

''';

// --------------------------------------------------


// -------- HoverExtensions Template Data ----------

const String kAppWebTemplateHoverExtensionsPath =
    'lib/extensions/hover_extensions.dart.stk';

const String kAppWebTemplateHoverExtensionsContent = '''
import 'package:{{packageName}}/ui/widgets/mouse_transforms/scale_on_hover.dart';
import 'package:{{packageName}}/ui/widgets/mouse_transforms/translate_on_hover.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension HoverExtensions on Widget {
  Widget get showCursorOnHover {
    return _returnUnalteredOnMobile(MouseRegion(
      cursor: SystemMouseCursors.click,
      child: this,
    ));
  }

  /// Moves the widget by x,y pixels on hover
  ///
  /// to move up use -y values, to move left use -x values
  Widget moveOnHover({double? x, double? y}) {
    return _returnUnalteredOnMobile(TranslateOnHover(
      x: x,
      y: y,
      child: this,
    ));
  }

  /// Scales the widget by [scale] on hover
  Widget scaleOnHover({double scale = 1.1}) {
    return _returnUnalteredOnMobile(ScaleOnHover(
      scale: scale,
      child: this,
    ));
  }

  /// Takes in the alteredWidget and if we detect we're on Android or iOS
  /// we return the unaltered widget.
  ///
  /// The reason we can do this is because all altered widgets require mouse
  /// functionality to work.
  Widget _returnUnalteredOnMobile(Widget alteredWidget) {
    if (kIsWeb) {
      return alteredWidget;
    }
    return this;
  }
}
''';

// --------------------------------------------------


// -------- Main Template Data ----------

const String kAppWebTemplateMainPath =
    'lib/main.dart.stk';

const String kAppWebTemplateMainContent = '''
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeDialogFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/{{{relativeRouterFilePath}}}';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_animate/flutter_animate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await setupLocator(stackedRouter: stackedRouter);
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (_) => MaterialApp.router(
        routerDelegate: stackedRouter.delegate(),
        routeInformationParser: stackedRouter.defaultRouteParser(),
      ),
    ).animate().fadeIn(
          delay: const Duration(milliseconds: 50),
          duration: const Duration(milliseconds: 400),
        );
  }
}

''';

// --------------------------------------------------


// -------- NoticeSheet Template Data ----------

const String kAppWebTemplateNoticeSheetPath =
    'lib/ui/bottom_sheets/notice/notice_sheet.dart.stk';

const String kAppWebTemplateNoticeSheetContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'notice_sheet_model.dart';

class NoticeSheet extends StackedView<NoticeSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;
  const NoticeSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NoticeSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceTiny,
          Text(
            request.description!,
            style: const TextStyle(fontSize: 14, color: kcMediumGrey),
            maxLines: 3,
            softWrap: true,
          ),
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  NoticeSheetModel viewModelBuilder(BuildContext context) =>
      NoticeSheetModel();
}

''';

// --------------------------------------------------


// -------- NoticeSheetModel Template Data ----------

const String kAppWebTemplateNoticeSheetModelPath =
    'lib/ui/bottom_sheets/notice/notice_sheet_model.dart.stk';

const String kAppWebTemplateNoticeSheetModelContent = '''
import 'package:stacked/stacked.dart';

class NoticeSheetModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- AppColors Template Data ----------

const String kAppWebTemplateAppColorsPath =
    'lib/ui/common/app_colors.dart.stk';

const String kAppWebTemplateAppColorsContent = '''
import 'package:flutter/material.dart';

const Color kcPrimaryColor = Color(0xFF9600FF);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcBlack = Color(0xFF000000);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcWhite = Color(0xFFFFFFFF);
const Color kcBackgroundColor = kcDarkGreyColor;

''';

// --------------------------------------------------


// -------- AppConstants Template Data ----------

const String kAppWebTemplateAppConstantsPath =
    'lib/ui/common/app_constants.dart.stk';

const String kAppWebTemplateAppConstantsContent = '''
/// The max width the content can ever take up on the screen
const double kdDesktopMaxContentWidth = 1150;

// The max height the homeview will take up
const double kdDesktopMaxContentHeight = 750;

''';

// --------------------------------------------------


// -------- AppStrings Template Data ----------

const String kAppWebTemplateAppStringsPath =
    'lib/ui/common/app_strings.dart.stk';

const String kAppWebTemplateAppStringsContent = '''
const String ksHomeBottomSheetTitle = 'Build Great Apps!';
const String ksHomeBottomSheetDescription =
    'Stacked is built to help you build better apps. Give us a chance and we\\'ll prove it to you. Check out stacked.filledstacks.com to learn more';

''';

// --------------------------------------------------


// -------- UiHelpers Template Data ----------

const String kAppWebTemplateUiHelpersPath =
    'lib/ui/common/ui_helpers.dart.stk';

const String kAppWebTemplateUiHelpersContent = '''
import 'dart:math';

import 'package:flutter/material.dart';

const double _tinySize = 5.0;
const double _smallSize = 10.0;
const double _mediumSize = 25.0;
const double _largeSize = 50.0;
const double _massiveSize = 120.0;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

Widget spacedDivider = const Column(
  children: <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);
double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 15);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(BuildContext context,
    {double? fontSize, double? max}) {
  max ??= 100;

  var responsiveSize = min(
      screenWidthFraction(context, dividedBy: 10) * ((fontSize ?? 100) / 100),
      max);
  
  return responsiveSize;
}

''';

// --------------------------------------------------


// -------- InfoAlertDialog Template Data ----------

const String kAppWebTemplateInfoAlertDialogPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog.dart.stk';

const String kAppWebTemplateInfoAlertDialogContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'info_alert_dialog_model.dart';

const double _graphicSize = 60;

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      verticalSpaceTiny,
                      Text(
                        request.description!,
                        style:
                            const TextStyle(fontSize: 14, color: kcMediumGrey),
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xffF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '⭐️',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(
                confirmed: true,
              )),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}

''';

// --------------------------------------------------


// -------- InfoAlertDialogModel Template Data ----------

const String kAppWebTemplateInfoAlertDialogModelPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog_model.dart.stk';

const String kAppWebTemplateInfoAlertDialogModelContent = '''
import 'package:stacked/stacked.dart';

class InfoAlertDialogModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- HomeView Template Data ----------

const String kAppWebTemplateHomeViewPath =
    'lib/ui/views/home/home_view.dart.stk';

const String kAppWebTemplateHomeViewContent = '''
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'home_view.desktop.dart';
import 'home_view.tablet.dart';
import 'home_view.mobile.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel  viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const HomeViewMobile(),
      tablet: (_) => const HomeViewTablet(),
      desktop: (_) => const HomeViewDesktop(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
  HomeViewModel();
}

''';

// --------------------------------------------------


// -------- HomeViewDesktop Template Data ----------

const String kAppWebTemplateHomeViewDesktopPath =
    'lib/ui/views/home/home_view.desktop.dart.stk';

const String kAppWebTemplateHomeViewDesktopContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/app_constants.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewDesktop extends ViewModelWidget<HomeViewModel> {
  const HomeViewDesktop({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: kdDesktopMaxContentWidth,
          height: kdDesktopMaxContentHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalSpaceLarge,
              Column(
                children: [
                  const Text(
                    'Hello, DESKTOP UI!',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  verticalSpaceMedium,
                  MaterialButton(
                    color: Colors.black,
                    onPressed: viewModel.incrementCounter,
                    child: Text(
                      viewModel.counterLabel,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: kcDarkGreyColor,
                    onPressed: viewModel.showDialog,
                    child: const Text(
                      'Show Dialog',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: kcDarkGreyColor,
                    onPressed: viewModel.showBottomSheet,
                    child: const Text(
                      'Show Bottom Sheet',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- HomeViewMobile Template Data ----------

const String kAppWebTemplateHomeViewMobilePath =
    'lib/ui/views/home/home_view.mobile.dart.stk';

const String kAppWebTemplateHomeViewMobileContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewMobile extends ViewModelWidget<HomeViewModel> {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    const Text(
                      'Hello, MOBILE UI!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceMedium,
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.incrementCounter,
                      child: Text(
                        viewModel.counterLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      onPressed: viewModel.showDialog,
                      child: const Text(
                        'Show Dialog',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      onPressed: viewModel.showBottomSheet,
                      child: const Text(
                        'Show Bottom Sheet',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- HomeViewTablet Template Data ----------

const String kAppWebTemplateHomeViewTabletPath =
    'lib/ui/views/home/home_view.tablet.dart.stk';

const String kAppWebTemplateHomeViewTabletContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewTablet extends ViewModelWidget<HomeViewModel> {
  const HomeViewTablet({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    const Text(
                      'Hello, TABLET UI!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceMedium,
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.incrementCounter,
                      child: Text(
                        viewModel.counterLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      onPressed: viewModel.showDialog,
                      child: const Text(
                        'Show Dialog',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      onPressed: viewModel.showBottomSheet,
                      child: const Text(
                        'Show Bottom Sheet',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- HomeViewmodel Template Data ----------

const String kAppWebTemplateHomeViewmodelPath =
    'lib/ui/views/home/home_viewmodel.dart.stk';

const String kAppWebTemplateHomeViewmodelContent = '''
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeDialogFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: \$_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked \$_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}

''';

// --------------------------------------------------


// -------- StartupView Template Data ----------

const String kAppWebTemplateStartupViewPath =
    'lib/ui/views/startup/startup_view.dart.stk';

const String kAppWebTemplateStartupViewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'STACKED',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Loading ...', style: TextStyle(fontSize: 16)),
                horizontalSpaceSmall,
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 6,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

''';

// --------------------------------------------------


// -------- StartupViewmodel Template Data ----------

const String kAppWebTemplateStartupViewmodelPath =
    'lib/ui/views/startup/startup_viewmodel.dart.stk';

const String kAppWebTemplateStartupViewmodelContent = '''
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/{{{relativeRouterFilePath}}}';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _routerService = locator<RouterService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    await _routerService.replaceWith(const HomeViewRoute());
  }
}

''';

// --------------------------------------------------


// -------- UnknownView Template Data ----------

const String kAppWebTemplateUnknownViewPath =
    'lib/ui/views/unknown/unknown_view.dart.stk';

const String kAppWebTemplateUnknownViewContent = '''
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'unknown_view.desktop.dart';
import 'unknown_view.tablet.dart';
import 'unknown_view.mobile.dart';
import 'unknown_viewmodel.dart';

class UnknownView extends StackedView<UnknownViewModel> {
  const UnknownView({super.key});

  @override
  Widget builder(
    BuildContext context,
    UnknownViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const UnknownViewMobile(),
      tablet: (_) => const UnknownViewTablet(),
      desktop: (_) => const UnknownViewDesktop(),
    );
  }

  @override
  UnknownViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UnknownViewModel();
}

''';

// --------------------------------------------------


// -------- UnknownViewDesktop Template Data ----------

const String kAppWebTemplateUnknownViewDesktopPath =
    'lib/ui/views/unknown/unknown_view.desktop.dart.stk';

const String kAppWebTemplateUnknownViewDesktopContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'unknown_viewmodel.dart';

class UnknownViewDesktop extends ViewModelWidget<UnknownViewModel> {
  const UnknownViewDesktop({super.key});

  @override
  Widget build(BuildContext context, UnknownViewModel viewModel) {
    return const Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.w800,
                height: 0.95,
                letterSpacing: 20.0,
              ),
            ),
            verticalSpaceSmall,
            Text(
              'PAGE NOT FOUND',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 20.0,
                wordSpacing: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- UnknownViewMobile Template Data ----------

const String kAppWebTemplateUnknownViewMobilePath =
    'lib/ui/views/unknown/unknown_view.mobile.dart.stk';

const String kAppWebTemplateUnknownViewMobileContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'unknown_viewmodel.dart';

class UnknownViewMobile extends ViewModelWidget<UnknownViewModel> {
  const UnknownViewMobile({super.key});

  @override
  Widget build(BuildContext context, UnknownViewModel viewModel) {
    return const Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.w800,
                height: 0.95,
                letterSpacing: 20.0,
              ),
            ),
            verticalSpaceSmall,
            Text(
              'PAGE NOT FOUND',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 20.0,
                wordSpacing: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';

// --------------------------------------------------


// -------- UnknownViewTablet Template Data ----------

const String kAppWebTemplateUnknownViewTabletPath =
    'lib/ui/views/unknown/unknown_view.tablet.dart.stk';

const String kAppWebTemplateUnknownViewTabletContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'unknown_viewmodel.dart';

class UnknownViewTablet extends ViewModelWidget<UnknownViewModel> {
  const UnknownViewTablet({super.key});

  @override
  Widget build(BuildContext context, UnknownViewModel viewModel) {
    return const Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.w800,
                height: 0.95,
                letterSpacing: 20.0,
              ),
            ),
            verticalSpaceSmall,
            Text(
              'PAGE NOT FOUND',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 20.0,
                wordSpacing: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- UnknownViewmodel Template Data ----------

const String kAppWebTemplateUnknownViewmodelPath =
    'lib/ui/views/unknown/unknown_viewmodel.dart.stk';

const String kAppWebTemplateUnknownViewmodelContent = '''
import 'package:stacked/stacked.dart';

class UnknownViewModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- ScaleOnHover Template Data ----------

const String kAppWebTemplateScaleOnHoverPath =
    'lib/ui/widgets/mouse_transforms/scale_on_hover.dart.stk';

const String kAppWebTemplateScaleOnHoverContent = '''
import 'package:flutter/material.dart';

class ScaleOnHover extends StatefulWidget {
  final double scale;
  final Widget child;
  // You can also pass the translation in here if you want to
  const ScaleOnHover({super.key, required this.child, this.scale = 1.1});

  @override
  State<ScaleOnHover> createState() => _ScaleOnHoverState();
}

class _ScaleOnHoverState extends State<ScaleOnHover> {
  final scaleTransform = Matrix4.identity()..scale(1.1);
  final noScaleTransform = Matrix4.identity()..scale(1.0);

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCirc,
        transform: _hovering ? scaleTransform : noScaleTransform,
        child: widget.child,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}
''';

// --------------------------------------------------


// -------- TranslateOnHover Template Data ----------

const String kAppWebTemplateTranslateOnHoverPath =
    'lib/ui/widgets/mouse_transforms/translate_on_hover.dart.stk';

const String kAppWebTemplateTranslateOnHoverContent = '''
import 'package:flutter/material.dart';

class TranslateOnHover extends StatefulWidget {
  final Widget child;
  final double? x;
  final double? y;
  // You can also pass the translation in here if you want to
  const TranslateOnHover({
    super.key,
    required this.child,
    this.x,
    this.y,
  });

  @override
  State<TranslateOnHover> createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
    final hoverTransform = Matrix4.identity()
      ..translate(
        widget.x ?? 0,
        widget.y ?? 0,
      );
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _hovering ? hoverTransform : nonHoverTransform,
        child: widget.child,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}
''';

// --------------------------------------------------


// -------- PubspecYamlStk Template Data ----------

const String kAppWebTemplatePubspecYamlStkPath =
    'pubspec.yaml.stk';

const String kAppWebTemplatePubspecYamlStkContent = '''
name: {{packageName}}
description: {{packageDescription}}
publish_to: 'none'
version: 0.1.0

environment:
  sdk: '>=3.0.3 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  stacked: ^3.4.0
  stacked_services: ^1.1.0
  url_strategy: ^0.2.0
  responsive_builder: ^0.7.0
  flutter_animate: ^4.1.1+1

dev_dependencies:
  build_runner: ^2.4.5
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  mockito: ^5.4.1
  stacked_generator: ^1.3.3

flutter:
  uses-material-design: true

''';

// --------------------------------------------------


// -------- READMEMdStk Template Data ----------

const String kAppWebTemplateREADMEMdStkPath =
    'README.md.stk';

const String kAppWebTemplateREADMEMdStkContent = '''
# {{packageName}}

{{packageDescription}}
''';

// --------------------------------------------------


// -------- StackedJsonStk Template Data ----------

const String kAppWebTemplateStackedJsonStkPath =
    'stacked.json.stk';

const String kAppWebTemplateStackedJsonStkContent = '''
{
    "bottom_sheets_path": "ui/bottom_sheets",
    "dialogs_path": "ui/dialogs",
    "line_length": 80,
    "locator_name": "locator",
    "prefer_web": true,
    "register_mocks_function": "registerServices",
    "services_path": "services",
    "stacked_app_file_path": "app/app.dart",
    "test_helpers_file_path": "helpers/test_helpers.dart",
    "test_services_path": "services",
    "test_views_path": "viewmodels",
    "test_widgets_path": "widget_models",
    "v1": false,
    "views_path": "ui/views",
    "widgets_path": "ui/widgets/common"
}
''';

// --------------------------------------------------


// -------- TestHelpers Template Data ----------

const String kAppWebTemplateTestHelpersPath =
    'test/helpers/test_helpers.dart.stk';

const String kAppWebTemplateTestHelpersContent = '''
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<RouterService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  // @stacked-mock-spec
])
void registerServices() {
  getAndRegisterRouterService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  // @stacked-mock-register
}

MockRouterService getAndRegisterRouterService() {
  _removeRegistrationIfExists<RouterService>();
  final service = MockRouterService();
  locator.registerSingleton<RouterService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

''';

// --------------------------------------------------


// -------- HomeViewmodelTest Template Data ----------

const String kAppWebTemplateHomeViewmodelTestPath =
    'test/viewmodels/home_viewmodel_test.dart.stk';

const String kAppWebTemplateHomeViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_viewmodel.dart';

import '{{{viewTestHelpersImport}}}';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('incrementCounter -', () {
      test('When called once should return  Counter is: 1', () {
        final model = getModel();
        model.incrementCounter();
        expect(model.counterLabel, 'Counter is: 1');
      });
    });

    group('showBottomSheet -', () {
      test('When called, should show custom bottom sheet using notice variant',
          () {
        final bottomSheetService = getAndRegisterBottomSheetService();

        final model = getModel();
        model.showBottomSheet();
        verify(bottomSheetService.showCustomSheet(
          variant: BottomSheetType.notice,
          title: ksHomeBottomSheetTitle,
          description: ksHomeBottomSheetDescription,
        ));
      });
    });
  });
}

''';

// --------------------------------------------------


// -------- InfoAlertDialogModelTest Template Data ----------

const String kAppWebTemplateInfoAlertDialogModelTestPath =
    'test/viewmodels/info_alert_dialog_model_test.dart.stk';

const String kAppWebTemplateInfoAlertDialogModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- NoticeSheetModelTest Template Data ----------

const String kAppWebTemplateNoticeSheetModelTestPath =
    'test/viewmodels/notice_sheet_model_test.dart.stk';

const String kAppWebTemplateNoticeSheetModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- UnknownViewmodelTest Template Data ----------

const String kAppWebTemplateUnknownViewmodelTestPath =
    'test/viewmodels/unknown_viewmodel_test.dart.stk';

const String kAppWebTemplateUnknownViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '../helpers/test_helpers.dart';

void main() {
  group('UnknownViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
''';

// --------------------------------------------------


// -------- FaviconPngStk Template Data ----------

const String kAppWebTemplateFaviconPngStkPath =
    'web/favicon.png.stk';

const String kAppWebTemplateFaviconPngStkContent = '''
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHaSURBVHgBpVTNasJAEN7dxLQl+FNEFBRR8VCQgo+gryCkh9499CnUg/gMvo3eFWw9eBLS4sWT2oOHRLOdWWLYxkRT+8GS3cnkm28mM0tIMOhpwzmn7plKdurawz9EdLtdNhqNWKvVekyn0ynLsghjTPg4jsNt26a6rnO09/v9r2Qy6UwmkwOlwoX7yZVqtWqA07v78uqKx+NmsVhsw179Jc4wDKVcLrejEvkXCHlBDlmdlkgkPm8lhKw+arWahipRKikUCspqtSqe2FOpFKnX6+QSZrMZ2W63Yr/b7Z6htshl45kOh8MnOWKj0eCXAD8vSKmOf54ho6qqnEREr9fDbjizZzIZikBCut/v6X/IENBeQikSck3TrnFdJJMghJ3V0L86nc5ZHbHOsk82m9WFUCTEzg8DkEVRhpOE6jhD57CUo5IR4tVQpMyCUg5KM0LKorH5crn8lqNhY4/HY9JsNkMVYWPLWK/XXutRmJQHGPQ5uXH0cGxLpdK9SNeVe8jlcgNyI2CWB6ZpHjwDjgxGyOfzb3+5JIBoXqlUXuG2uSOnHpQCUSi0slgs7qCNVAwCEHXZbDZYV+8sZpYxJxaLHaFc1nQ6PYLZCcsAy6BIT0U6eza83X2CBH4AHNJFlWlQookAAAAASUVORK5CYII=
''';

// --------------------------------------------------


// -------- IndexHtmlStk Template Data ----------

const String kAppWebTemplateIndexHtmlStkPath =
    'web/index.html.stk';

const String kAppWebTemplateIndexHtmlStkContent = '''
<!DOCTYPE html>
<html>

<head>
  <!--
    If you are serving your web app in a path other than the root, change the
    href value below to reflect the base path you are serving from.

    The path provided below has to start and end with a slash "/" in order for
    it to work correctly.

    For more details:
    * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base

    This is a placeholder for base href that will be replaced by the value of
    the `--base-href` argument provided to `flutter build`.
  -->
  <base href="\$FLUTTER_BASE_HREF">

  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="{{packageDescription}}">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="FilledStacks Academy">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png" />

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  

  <title>My Stacked Application</title>
  <link rel="manifest" href="manifest.json">

  <script>
    // The value below is injected by flutter build, do not touch.
    var serviceWorkerVersion = null;
  </script>
  <!-- This script adds the flutter initialization JS code -->
  <script src="flutter.js" defer></script>
</head>

<body>
  <style>
    
    body {
      background-color: #0A0A0A;
      height: 100vh;
      width: 100vw;
      position: fixed;
      inset: 0px;
      overflow: hidden;
      padding: 0px;
      margin: 0px;
      user-select: none;
      touch-action: none;
    }

    .main-content {
      height: 100%;
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: opacity .4s ease-out;
    }

    img {
      width: 100px;
      height: 100px;
      position: absolute;
    }

    p {
      color: #fff;
    }


    .loader {
      position: relative;
      width: 250px;
      height: 250px;
      border-radius: 50%;
      background: linear-gradient(#f07e6e, #84cdfa, #5ad1cd);
      animation: animate 1.2s linear infinite;
    }

    @keyframes animate {
      0% {
        transform: rotate(0deg);
      }

      100% {
        transform: rotate(360deg);
      }
    }

    .loader span {
      position: absolute;
      width: 100%;
      height: 100%;
      border-radius: 60%;
      background: linear-gradient(#f07e6e, #84cdfa, #5ad1cd);
    }

    .loader span:nth-child(1) {
      filter: blur(5px);
    }

    .loader span:nth-child(2) {
      filter: blur(10px);
    }

    .loader span:nth-child(3) {
      filter: blur(25px);
    }

    .loader span:nth-child(4) {
      filter: blur(50px);
    }

    .loader:after {
      content: '';
      position: absolute;
      top: 10px;
      left: 10px;
      right: 10px;
      bottom: 10px;
      background: #191919;
      border-radius: 50%;
    }
  </style>
  <script>
    function delay(time) {
      return new Promise(resolve => setTimeout(resolve, time));
    }

    window.addEventListener('load', function (ev) {
      var loaderContent = document.querySelector('#loader-content');
      // Download main.dart.js
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        }
      }).then(function (engineInitializer) {
        return engineInitializer.initializeEngine();
      }).then(async function (appRunner) {
        loaderContent.style.opacity = "0";
        await delay(400);
        await appRunner.runApp();
      });
    });
  </script>
  <div class="main-content" id="loader-content">
    <div class="loader">
      <span></span>
      <span></span>
      <span></span>
      <span></span>
    </div>
    <img src="main-icon.png" />
  </div>
</body>

</html>
''';

// --------------------------------------------------


// -------- MainIconPngStk Template Data ----------

const String kAppWebTemplateMainIconPngStkPath =
    'web/main-icon.png.stk';

const String kAppWebTemplateMainIconPngStkContent = '''
iVBORw0KGgoAAAANSUhEUgAAALMAAACzCAYAAADCFC3zAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAN5SURBVHgB7daLjVNBDEDRF0QjVEIrdMLSAS3RyZZAByGWdqUQ5Z/5eGbOkSw3cC152wAAAAAAAAAAAAAAAACAjHZbYfuDDW77tdvt3raCvmzQXvGQg5hprUrIQcy0VC3kIGZaqRpyEDMtVA85iJnamoQcxExNzUIOYqaWpiEHMVND85CDmCmtS8hBzJTULeQgZkrpGnIQMyV0DzmImVelCDmImVekCTmImWelCjmImWekCzmImUelDDmImUekDTmImXulDjmImXukDzmImVuGCDmImWuGCTmImUuGCjmImXOGCzmImVNDhhzEzLFhQw5i5tPQIQcxE4YPOYiZKUIOYl7bNCEHMa9rqpCDmNc0XchBzOuZMuQg5rVMG3IQ8zqmDjmIeQ3ThxzEPL8lQg5intsyIQcxz2upkIOY57RcyEHM81ky5CDmuSwbchDzPJYOOYh5DsuHHMQ8PiF/EPPYhHxEzOMS8gkxj0nIZ4h5PEK+QMxjEfIVYh6HkG8Q8xiEfAcx5yfkO4k5NyE/QMx5CflBYs5JyE8Qcz5CfpKYcxHyC8Sch5BfJOYchFyAmPsTciFi7kvIBYm5HyEXJuY+hFyBmNsTciVibkvIFYm5HSFXttsK2+/3bxunvh/mz8axv4fj/r0VVDxm/nc47p+H9bZx6v0Q87etIG9GRUJuS8yVCLk9MVcg5D7EXJiQ+xFzQULuS8yFCLk/MRcg5BzE/CIh5yHmFwg5FzE/Scj5iPkJQs5JzA8Scl5ifoCQcxPznYScn5jvIOQxiPkGIY9DzFcIeSxivkDI4xHzGUIek5hPCHlcYj4i5LGJ+YOQxyfmTcizWD5mIc9j6ZiFPJdlYxbyfJaMWchzWi5mIc9rqZiFPLdlYhby/JaIWchrmD5mIa9j6piFvJZpYxbyeqaMWchrmi5mIa9rqpiFvLZpYhYyU8QsZMLwMQuZT0PHLGSODRuzkDk1ZMxC5pzhYhYylwwVs5C5ZpiYhcwtQ8QsZO6RPmYhc6/UMQuZR6SNWcg8KmXMQuYZ6WIWMs9KFbOQeUWamIXMq1LELGRK6B6zkCmla8xCpqRuMQuZ0rrELGRqaB6zkKmlacxCpqZmMQuZ2prELGRaqB6zkGmlasxCpqVqMQuZ1qrELGR6+LoVdgj5x2HFvG9w2fsGAAAAAAAAAAAAAAAAACzhH8sFZqawpyetAAAAAElFTkSuQmCC
''';

// --------------------------------------------------


// -------- GenericSheet Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetPath =
    'lib/ui/bottom_sheets/generic/generic_sheet.dart.stk';

const String kBottomSheetEmptyTemplateGenericSheetContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class {{sheetName}} extends StatelessWidget {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const {{sheetName}}({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Hello Stacked Sheet!!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          if (request.description != null) ...[
            verticalSpaceTiny,
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14, color: kcMediumGrey),
              maxLines: 3,
              softWrap: true,
            ),
          ],
          verticalSpaceLarge,
        ],
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericSheetModel Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetModelPath =
    'lib/ui/bottom_sheets/generic/generic_sheet_model.dart.stk';

const String kBottomSheetEmptyTemplateGenericSheetModelContent = '''
import 'package:stacked/stacked.dart';

class {{sheetModelName}} extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- GenericSheetUseModel Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetUseModelPath =
    'lib/ui/bottom_sheets/generic/generic_sheet_use_model.dart.stk';

const String kBottomSheetEmptyTemplateGenericSheetUseModelContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '{{sheetModelFilename}}';

class {{sheetName}} extends StackedView<{{sheetModelName}}> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const {{sheetName}}({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    {{sheetModelName}} viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Hello Stacked Sheet!!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          if (request.description != null) ...[
            verticalSpaceTiny,
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14, color: kcMediumGrey),
              maxLines: 3,
              softWrap: true,
            ),
          ],
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  {{sheetModelName}} viewModelBuilder(BuildContext context) =>
      {{sheetModelName}}();
}

''';

// --------------------------------------------------


// -------- GenericSheetModelTest Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetModelTestPath =
    'test/viewmodels/generic_sheet_model_test.dart.stk';

const String kBottomSheetEmptyTemplateGenericSheetModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('{{sheetModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericDialog Template Data ----------

const String kDialogEmptyTemplateGenericDialogPath =
    'lib/ui/dialogs/generic/generic_dialog.dart.stk';

const String kDialogEmptyTemplateGenericDialogContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

const double _graphicSize = 60;

class {{dialogName}} extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const {{dialogName}}({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title ?? 'Hello Stacked Dialog!!',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kcMediumGrey,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('⭐️', style: TextStyle(fontSize: 30)),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericDialogModel Template Data ----------

const String kDialogEmptyTemplateGenericDialogModelPath =
    'lib/ui/dialogs/generic/generic_dialog_model.dart.stk';

const String kDialogEmptyTemplateGenericDialogModelContent = '''
import 'package:stacked/stacked.dart';

class {{dialogModelName}} extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- GenericDialogUseModel Template Data ----------

const String kDialogEmptyTemplateGenericDialogUseModelPath =
    'lib/ui/dialogs/generic/generic_dialog_use_model.dart.stk';

const String kDialogEmptyTemplateGenericDialogUseModelContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '{{dialogModelFilename}}';

const double _graphicSize = 60;

class {{dialogName}} extends StackedView<{{dialogModelName}}> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const {{dialogName}}({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    {{dialogModelName}} viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title ?? 'Hello Stacked Dialog!!',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kcMediumGrey,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('⭐️', style: TextStyle(fontSize: 30)),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  {{dialogModelName}} viewModelBuilder(BuildContext context) =>
      {{dialogModelName}}();
}

''';

// --------------------------------------------------


// -------- GenericDialogModelTest Template Data ----------

const String kDialogEmptyTemplateGenericDialogModelTestPath =
    'test/viewmodels/generic_dialog_model_test.dart.stk';

const String kDialogEmptyTemplateGenericDialogModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('{{dialogModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericService Template Data ----------

const String kServiceEmptyTemplateGenericServicePath =
    'lib/services/generic_service.dart.stk';

const String kServiceEmptyTemplateGenericServiceContent = '''
class {{serviceName}} {

}
''';

// --------------------------------------------------


// -------- GenericServiceTest Template Data ----------

const String kServiceEmptyTemplateGenericServiceTestPath =
    'test/services/generic_service_test.dart.stk';

const String kServiceEmptyTemplateGenericServiceTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{serviceTestHelpersImport}}}';

void main() {
  group('{{serviceName}}Test -', () {
    setUp(() => {{registerMocksFunction}}());
    tearDown(() => {{locatorName}}.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericView Template Data ----------

const String kViewEmptyTemplateGenericViewPath =
    'lib/ui/views/generic/generic_view.dart.stk';

const String kViewEmptyTemplateGenericViewContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}} extends StackedView<{{viewModelName}}> {
  const {{viewName}}({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    {{viewModelName}} viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("{{viewName}}")),
      ),
    );
  }

  @override
  {{viewModelName}} viewModelBuilder(
    BuildContext context,
  ) => {{viewModelName}}();
}
''';

// --------------------------------------------------


// -------- GenericViewmodel Template Data ----------

const String kViewEmptyTemplateGenericViewmodelPath =
    'lib/ui/views/generic/generic_viewmodel.dart.stk';

const String kViewEmptyTemplateGenericViewmodelContent = '''
import 'package:stacked/stacked.dart';

class {{viewModelName}} extends BaseViewModel {}
''';

// --------------------------------------------------


// -------- GenericViewV1 Template Data ----------

const String kViewEmptyTemplateGenericViewV1Path =
    'lib/ui/views/generic/generic_view_v1.dart.stk';

const String kViewEmptyTemplateGenericViewV1Content = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}} extends StatelessWidget {
  const {{viewName}}({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<{{viewModelName}}>.reactive(
      viewModelBuilder: () => {{viewModelName}}(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        ),
      ),
    );
  }
}
''';

// --------------------------------------------------


// -------- GenericViewmodelTest Template Data ----------

const String kViewEmptyTemplateGenericViewmodelTestPath =
    'test/viewmodels/generic_viewmodel_test.dart.stk';

const String kViewEmptyTemplateGenericViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('{{viewModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericView Template Data ----------

const String kViewWebTemplateGenericViewPath =
    'lib/ui/views/generic/generic_view.dart.stk';

const String kViewWebTemplateGenericViewContent = '''
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '{{viewFileNameWithoutExtension}}.desktop.dart';
import '{{viewFileNameWithoutExtension}}.tablet.dart';
import '{{viewFileNameWithoutExtension}}.mobile.dart';
import '{{viewModelFileName}}';

class {{viewName}} extends StackedView<{{viewModelName}}> {
  const {{viewName}}({super.key});

  @override
  Widget builder(
    BuildContext context,
    {{viewModelName}}  viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const {{viewName}}Mobile(),
      tablet: (_) => const {{viewName}}Tablet(),
      desktop: (_) => const {{viewName}}Desktop(),
    );
  }

  @override
  {{viewModelName}} viewModelBuilder(
    BuildContext context,
  ) =>
  {{viewModelName}}();
}

''';

// --------------------------------------------------


// -------- GenericViewDesktop Template Data ----------

const String kViewWebTemplateGenericViewDesktopPath =
    'lib/ui/views/generic/generic_view.desktop.dart.stk';

const String kViewWebTemplateGenericViewDesktopContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}}Desktop extends ViewModelWidget<{{viewModelName}}> {
  const {{viewName}}Desktop({super.key});

  @override
  Widget build(BuildContext context, {{viewModelName}} viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI - {{viewName}}!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericViewMobile Template Data ----------

const String kViewWebTemplateGenericViewMobilePath =
    'lib/ui/views/generic/generic_view.mobile.dart.stk';

const String kViewWebTemplateGenericViewMobileContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}}Mobile extends ViewModelWidget<{{viewModelName}}> {
  const {{viewName}}Mobile({super.key});

  @override
  Widget build(BuildContext context, {{viewModelName}} viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, MOBILE UI - {{viewName}}!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericViewTablet Template Data ----------

const String kViewWebTemplateGenericViewTabletPath =
    'lib/ui/views/generic/generic_view.tablet.dart.stk';

const String kViewWebTemplateGenericViewTabletContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}}Tablet extends ViewModelWidget<{{viewModelName}}> {
  const {{viewName}}Tablet({super.key});

  @override
  Widget build(BuildContext context, {{viewModelName}} viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI - {{viewName}}!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericViewmodel Template Data ----------

const String kViewWebTemplateGenericViewmodelPath =
    'lib/ui/views/generic/generic_viewmodel.dart.stk';

const String kViewWebTemplateGenericViewmodelContent = '''
import 'package:stacked/stacked.dart';

class {{viewModelName}} extends BaseViewModel {
}
''';

// --------------------------------------------------


// -------- GenericViewmodelTest Template Data ----------

const String kViewWebTemplateGenericViewmodelTestPath =
    'test/viewmodels/generic_viewmodel_test.dart.stk';

const String kViewWebTemplateGenericViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('{{viewModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- Generic Template Data ----------

const String kWidgetEmptyTemplateGenericPath =
    'lib/ui/widgets/common/generic/generic.dart.stk';

const String kWidgetEmptyTemplateGenericContent = '''
import 'package:flutter/material.dart';

class {{widgetName}} extends StatelessWidget {
  const {{widgetName}}({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

''';

// --------------------------------------------------


// -------- GenericModel Template Data ----------

const String kWidgetEmptyTemplateGenericModelPath =
    'lib/ui/widgets/common/generic/generic_model.dart.stk';

const String kWidgetEmptyTemplateGenericModelContent = '''
import 'package:stacked/stacked.dart';

class {{widgetModelName}} extends BaseViewModel {}
''';

// --------------------------------------------------


// -------- GenericUseModel Template Data ----------

const String kWidgetEmptyTemplateGenericUseModelPath =
    'lib/ui/widgets/common/generic/generic_use_model.dart.stk';

const String kWidgetEmptyTemplateGenericUseModelContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{widgetModelFileName}}';

class {{widgetName}} extends StackedView<{{widgetModelName}}> {
  const {{widgetName}}({super.key});

  @override
  Widget builder(
    BuildContext context,
    {{widgetModelName}} viewModel,
    Widget? child,
  ) {
    return const SizedBox.shrink();
  }

  @override
  {{widgetModelName}} viewModelBuilder(
    BuildContext context,
  ) => {{widgetModelName}}();
}
''';

// --------------------------------------------------


// -------- GenericModelTest Template Data ----------

const String kWidgetEmptyTemplateGenericModelTestPath =
    'test/widget_models/generic_model_test.dart.stk';

const String kWidgetEmptyTemplateGenericModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{widgetTestHelpersImport}}}';

void main() {
  group('{{widgetModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


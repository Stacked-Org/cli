/// Stores all the messages used throughout the app that communicates
/// with the user of the package.
library;

/// Message shown when we encounter a failure during generation that's caused by an invalid
/// app structure.
const String kInvalidStackedStructureAppFile =
    'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/';

/// The message shows when we detect no pubspec.yaml file in the folder that the cli is
/// running from.
const String kInvalidRootDirectory = '''
    No pubspec.yaml detected. It seems that you are not running the cli from the root of a flutter project. 
    Please ensure that you are in the root of a flutter project when using stacked_cli.
    ''';

/// The message shown when we detect that the stacked structure does not follow the latest
/// recommendation of the file structure.
const String kInvalidStackedStructure = '''
No app.dart found in lib/app folder. We currently do not support scaffolding for stacked apps
that do not make use of the app.dart file for route generation and dependency inversion.

We have plans to support this in the future. If you want to help build it, check out the project
for the stacked-cli roadmap.
''';

const String kCommandHelpVersion = 'Print the current version.';

const String kCommandHelpEnableAnalytics = 'Enable Analytics.';

const String kCommandHelpDisableAnalytics = 'Disable Analytics.';

const String kCommandHelpExcludeRoute =
    'When a route is excluded it will not be added to your app.dart routes collection.';

const String kCommandHelpV1 =
    'When v1 or use-builder is provided, ViewModelBuilder will be used instead of StackedView.';

const String kCommandHelpAppMinimalTemplate =
    'Specifies creating using an application template with a main.dart that is minimal, including no comments.';

const String kCommandHelpAppDescription =
    'The description to use for your new Flutter project. This string ends up in the pubspec.yaml file.';

const String kCommandHelpAppOrganization =
    'The organization responsible for your new Flutter project, in reverse domain name notation.';

const String kCommandHelpAppPlatforms =
    'The platforms supported by this project. Platform folders (e.g. android/) will be generated in the target project.';

const String kCommandHelpModel =
    'When model is provided, StackedView will be used instead of StatelessWidget and a Model will be created.';

const String kCommandHelpLineLength =
    'When a number is provided, it will be used as the line length for formatting code.';

const String kCommandHelpCreateAppTemplate =
    'Selects the type of starter template to use when creating a new app. One oriented for mobile first or web first.';

const String kCommandHelpConfigFilePath =
    'Sets the file path for the custom config.';

const String kCommandHelpPath = 'Sets the relative path for the component.';

const String kCommandHelpCreateServiceTemplate =
    'Selects the type of service to create instead of the default empty service.';

const String kCommandHelpCreateViewTemplate =
    'Selects the type of view to create instead of the default empty view.';

const String kCommandHelpCreateWidgetTemplate =
    'Selects the type of widget to create instead of the default empty widget.';

const String kCommandHelpCreateDialogTemplate =
    'Selects the type of dialog to create instead of the default empty dialog.';

const String kCommandHelpCreateBottomSheetTemplate =
    'Selects the type of bottom sheet to create instead of the default empty bottom sheet.';

const String kCommandHelpExcludeDependency =
    'When a service is excluded it will not be added to your app.dart dependencies collection.';

const String kCommandHelpWatch =
    'Generates the code for the Stacked application, watching the file system for updates and rebuilding as appropriate.';

const String kCommandHelpDeleteConflictingOutputs =
    'Assume conflicting outputs in the users package are from previous builds, and skip the user prompt that would usually be provided.';

const String kConfigFileNotFound =
    'No configuration file found. Default Stacked values will be used.';

const String kConfigFileNotFoundRetry =
    'No configuration file found. Please, verify the config path passed as argument.';

const String kConfigFileMalformed =
    'Your configuration file is malformed. Double check to make sure you have properly formatted json.';

const String kDeprecatedConfigFileName = '''
Stacked config file should be renamed from "stacked.config.json" to "stacked.json". Stacked cli will not read "stacked.config.json" files after the next minor release.
''';

const String kDeprecatedPaths = '''
Paths on Stacked config do not need to start with directory "lib" or "test" because  are mandatory directories, defined by the Flutter framework. Stacked cli will not accept paths starting with "lib" or "test" after the next minor release.
''';

const String kCommandHelpProjectPath = '''
When path is provided, it will be considered the project directory instead of the current directory.
''';

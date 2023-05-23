# [1.8.0](https://github.com/Stacked-Org/cli/compare/v1.7.3...v1.8.0) (2023-05-23)


### Features

* add watch argument to generate command ([#20](https://github.com/Stacked-Org/cli/issues/20)) ([ccbd585](https://github.com/Stacked-Org/cli/commit/ccbd5854fd835430649ade4e09b76b8bfb8555ff))

## [1.7.3](https://github.com/Stacked-Org/cli/compare/v1.7.2...v1.7.3) (2023-05-18)


### Bug Fixes

* Bump environment constraints to <4 ([286a76a](https://github.com/Stacked-Org/cli/commit/286a76abcfee1eb5059a6ebff2c92d22f9ac6e71))

## [1.7.2](https://github.com/Stacked-Org/cli/compare/v1.7.1...v1.7.2) (2023-05-12)


### Bug Fixes

* flutter format depreciation in favor of dart format ([#19](https://github.com/Stacked-Org/cli/issues/19)) ([e830c59](https://github.com/Stacked-Org/cli/commit/e830c59b003e14508d4feea2a4cbd9861e219e1c))

## [1.7.1](https://github.com/Stacked-Org/cli/compare/v1.7.0...v1.7.1) (2023-04-20)


### Bug Fixes

* **cli:** update deprecated property on view templates ([#15](https://github.com/Stacked-Org/cli/issues/15)) ([48f3356](https://github.com/Stacked-Org/cli/commit/48f33560701f9c159f03fb2356c3633edf36356c))

# [1.7.0](https://github.com/Stacked-Org/cli/compare/v1.6.5...v1.7.0) (2023-04-20)


### Features

* **cli:** add VSCode settings to app templates ([#14](https://github.com/Stacked-Org/cli/issues/14)) ([bf296fb](https://github.com/Stacked-Org/cli/commit/bf296fb27941010892f7610645a76fc68c707a95))

## [1.6.5](https://github.com/Stacked-Org/cli/compare/v1.6.4...v1.6.5) (2023-04-18)


### Bug Fixes

* stacked.json format on template ([#13](https://github.com/Stacked-Org/cli/issues/13)) ([465789f](https://github.com/Stacked-Org/cli/commit/465789f40405053ba5a66862663b76b1ec9a61d8))

## [1.6.4](https://github.com/Stacked-Org/cli/compare/v1.6.3...v1.6.4) (2023-04-18)


### Bug Fixes

* Web app template ([#12](https://github.com/Stacked-Org/cli/issues/12)) ([0e96bbe](https://github.com/Stacked-Org/cli/commit/0e96bbec8ab845cee994b98959139d6bfde44e06))

## [1.6.3](https://github.com/Stacked-Org/cli/compare/v1.6.2...v1.6.3) (2023-04-14)


### Bug Fixes

* updates stacked_generator version to latest ([6f720c0](https://github.com/Stacked-Org/cli/commit/6f720c077bdfd0214999c5b2da97c10ca13c2722))

## [1.6.2](https://github.com/Stacked-Org/cli/compare/v1.6.1...v1.6.2) (2023-04-11)


### Bug Fixes

* **deps:** update dependency pub_updater to ^0.3.0 ([#11](https://github.com/Stacked-Org/cli/issues/11)) ([71fb5b8](https://github.com/Stacked-Org/cli/commit/71fb5b8e46c7ee13e93d7969c50c35f60d783d66))

## [1.6.1](https://github.com/Stacked-Org/cli/compare/v1.6.0...v1.6.1) (2023-04-10)


### Bug Fixes

* update HoverExtensions ([#9](https://github.com/Stacked-Org/cli/issues/9)) ([20955c9](https://github.com/Stacked-Org/cli/commit/20955c9a76fc0f580f5857b9148a1e006bbf574e))

# [1.6.0](https://github.com/Stacked-Org/cli/compare/v1.5.2...v1.6.0) (2023-04-10)


### Features

* add Unknown view to Web template ([#8](https://github.com/Stacked-Org/cli/issues/8)) ([d54c8e9](https://github.com/Stacked-Org/cli/commit/d54c8e95479021a02091612119769e75c8276b74))

## [1.5.2](https://github.com/Stacked-Org/cli/compare/v1.5.1...v1.5.2) (2023-03-29)


### Bug Fixes

* bad state error on no argument ([#7](https://github.com/Stacked-Org/cli/issues/7)) ([3766e7f](https://github.com/Stacked-Org/cli/commit/3766e7f87482b2c78669eb864eb26738b1e72e68))

## [1.5.1](https://github.com/Stacked-Org/cli/compare/v1.5.0...v1.5.1) (2023-03-17)


### Bug Fixes

* Adds generated code ([#6](https://github.com/Stacked-Org/cli/issues/6)) ([5c607b5](https://github.com/Stacked-Org/cli/commit/5c607b5d4f9a8cd5d3fccd248f0117ae2059443f))

# [1.5.0](https://github.com/Stacked-Org/cli/compare/v1.4.0...v1.5.0) (2023-03-17)


### Features

* Update web template routes and intro animation ([#5](https://github.com/Stacked-Org/cli/issues/5)) ([d2968cb](https://github.com/Stacked-Org/cli/commit/d2968cbb356f4d1d5f2690bc41d17a01bcf589f0))

## 1.4.1

- Updates the app web template to use the new `RoutingService`
- Updates web template to the latest versions of all packages
- Adds a `web` template to `stacked create view` _Fixes #889_
- Adds priority for templates based on config. If `prefer_web` is true in your config then you don't have to pass `--template=web` when creating a view

## 1.4.0

- Adds HoverExtensions fo the web template for easier hover effects
- Wraps `MaterialApp` with `ResponsiveApp` in `main.dart` for web template

## 1.3.3

- Fixes to avoid StateError when HOME environment variable not set. When this situation happens, XDG_CONFIG_HOME location is not taken into account to find stacked config

## 1.3.2

- Avoids running pub command if has last version on the system
- Avoids notify new version available for compile and update commands

## 1.3.1

- Fixes create service bug introduced in 1.3.0

## 1.3.0
### New Feature
Adds template functionality to the create commands and adds a new --template=web template for creating a Web app with Stacked.

## 1.2.0

- Adds support for `version` custom dimension
- Adds support for `name` custom dimension
- Sends `stacked_cli` version custom dimension on every event

## 1.1.12

- Changes executableName to `stacked`
- Refactors `_handleVersion` to use PubService
- Updates `_handleFirstRun` for prettier notification
- Shows notification when new version is available

## 1.1.11

- Updates create bottom_sheet command to make use of StackedApp annotation
- Updates create dialog command to make use of StackedApp annotation
- Updates packages

## 1.1.10

- Adds `model` flag option to create bottom_sheet command to use or not a model
- Adds `model` flag option to create dialog command to use or not a model

## 1.1.9+1

- Refactor ProcessService
- Improves version global option to be retrieved on the fly

## 1.1.9

- Fixes version global option

## 1.1.8

- Adds global option to show `stacked_cli` version
- Adds global option to enable sending of analytics data
- Adds global option to disable sending of analytics data
- Adds prompt for sending analytics at first run
- Fixes unit tests
- Fix: Delete service command removes correct dependencies and code

## 1.1.7

- Logs exception events to Google Analytics

## 1.1.6

- Adds create dialog command
- Improves shouldAppendTemplate function
- Executes `clean` function on create app command to
  - Deletes widget_test.dart file
  - Removes unused imports

## 1.1.5

- Fixes support for relative router file path

## 1.1.4

- Adds create bottom_sheet command
- Improves templates
- Improves analytics responsiveness, no more delays on commands execution
- Updates example app

## 1.1.3+1

- Replaces `stacked_tools` strings with `stacked_cli`

## 1.1.3

- Updates the `HomeViewModel` template to use `rebuildUi` instead of `notifyListeners`
- Updates `StartupViewModel` to use type safe navigation when going to the `HomeView`

## 1.1.2

- Adds the new Update command

## 1.1.1+1

- Updates cli link in readme
- Sets `runInShell` true in an attempt to fix [this issue](https://github.com/FilledStacks/stacked/issues/811?notification_referrer_id=NT_kwDOADbP6rI1MjQxODI0ODQ5OjM1OTIxNzA)

## 1.1.1

- Adds google analytics to see where to improve the app

## 1.1.0

We had to update this package version to 1.1.0 because this package use to belong to a different developer. They released starting at 1.0.0. This is why we're suddenly jumping from 0.2.6 to 1.1.0.

## 0.2.6

- Adds the new Generate command

## 0.2.5

- Adds Stacked route observer to app template

## 0.2.4

- Promotes the package to stable

## 0.2.4-beta.4

- Removes lib and test folder from the default paths because there is no need to include them as they can't be changed
- Changes getImportPath to sanitizePath, more appropriate method name
- Removes path of app name, if any, to render template
- Changes Stacked config filename to `stacked.json`
- Changes ConfigService to support XDG_CONFIG_HOME
- Moves again loadConfig to each command instead of bootstrap

## 0.2.4-beta.3

- Updates the compiled templates since the template was changes
- Updates viewModelBuilder on templates to use short hand function notation
- Updates ViewModel instance name from model to viewModel
- Updates StackedView template builder indentation

## 0.2.4-beta.2

- Removes the depdency override for stacked

## 0.2.4-beta.1

- Add lineLength to Config model
- Update stacked config on templates
- Use ConfigService for _formattingLineLength default value
- Add line-length option support to create app command
- Load configuration on bootstrap instead of each command
- Fix replaceCustomPaths, now only process values which keys contains `path` word
- Update example app

## 0.2.4-beta.0

- Changes View template to use StackedView, aka ViewModelWidget, as default
- Adds config option `v1` to use alternative view builder style
- Adds flag option `v1` to use alternative view builder style, overrides config option
- Adds `v1`support for create app command
- Removes `widget_test` after on create app command
- Uses relativeLocatorPath on every template
- Fixes TestHelpers import on views and services tests
- Improves getFilePathToHelpersAndMocks
- Updates example app to align changes

## 0.2.3-beta.0

- Fixes testHelpersPath default value
- Adds test_helpers filename to service_test template
- Changes default values on stacked config template
- Loads config on create app command

## 0.2.2

- Fixes the generated stacked config file

## 0.2.1

### Additions
- Adds config option to set the name of the locator used to register mocks for testing
- Adds config option to set the name of the function that registers all mocks for testing

### Fixes
- Makes test_helpers_path replace the entire value with the new value provided
- Fixes hard check for test location

## 0.2.0

### Feature: Stacked config
- Adds stacked config so you can use different paths for your file generation making it usable with all projects

### Bugs
- Fixes: Duplicate import in test_helper.dart file

## 0.2.0

- Adds stacked config so you can use different paths for your generating

## 0.1.6
- Updates Formatting to be only on specific files 
- Adds line-length or -l option for formatting length default is 80
- Adds delete service command 

## 0.1.5
- Updates dependencies 
  
## 0.1.4

- Adds colorized outputs on command line
- Runs build runner and pub get on view and service creation
- Adds delete command for views
  - you can now run `stacked delete view view_name ` to delete view_name view,viewmodel and tests also remove view from `app.dart`  
- Fixes wrong pubspec.yaml file selection on non-root commands

## 0.1.2+1

- Adds documentation link to basic docs

## 0.1.2

- Fixes bug that loads pubspec on project create

## 0.1.1

- Adds executable to the pubspec for global activation
- Fixes template bugs for app generate

## 0.1.0

### Initial Release

This version of the cli has 3 create commands:
- stacked create app: This creates a brand new flutter project with all the stacked functionality setup
- stacked create view: This creates a new view in the project and makes all required changes
- stacked create service: This creates a new service in the project and makes all required changes

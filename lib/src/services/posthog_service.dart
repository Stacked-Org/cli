import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_cli/src/exceptions/posthog_api_key_not_found_exception.dart';
import 'package:stacked_cli/src/locator.dart';

import 'colorized_log_service.dart';
import 'path_service.dart';
import 'pub_service.dart';

const String _apiKey = String.fromEnvironment('POSTHOG_API_KEY');

const String _isFirstRunKey = 'isAnalyticsFirstRun';
const String _isEnabledKey = 'isAnalyticsEnabled';

class PosthogService {
  final bool verbose;
  PosthogService({this.verbose = false});

  final _log = locator<ColorizedLogService>();
  final _pubService = locator<PubService>();
  final _pathService = locator<PathService>();

  final _baseUri = Uri.parse('https://app.posthog.com/capture');

  /// Is this the first time the tool has run?
  bool get isFirstRun => _box.get(_isFirstRunKey, defaultValue: true);

  /// Will analytics data be sent?
  bool get enabled => _box.get(_isEnabledKey, defaultValue: false);

  /// Enables or disables sending of analytics data.
  Future<void> enable(bool value) async {
    await _box.put(_isFirstRunKey, false);
    await _box.put(_isEnabledKey, value);
  }

  late Box _box;

  Future<void> init() async {
    Hive.init('${_pathService.configHome.path}/stacked');

    _box = await Hive.openBox(
      'telemetry_config',
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 50,
    );
  }

  Future<void> _capture({
    required String event,
    Map<String, dynamic> properties = const {},
  }) async {
    try {
      if (!enabled) return;

      if (_apiKey.isEmpty) throw PostHogApiKeyNotFoundException();

      final version = await _pubService.getCurrentVersion();

      final response = await http.post(
        _baseUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "api_key": _apiKey,
          "event": event,
          "properties": {
            "distinct_id": "Anonymous",
            ...properties,
            "version": version,
          }
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) throw Exception(data);
    } on PostHogApiKeyNotFoundException catch (e) {
      _log.error(message: e.toString());
    } catch (e, s) {
      _log.error(message: 'Error: Event could not be sent!, StackTrace:\n$s');
    }
  }

  Future<void> createAppEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Create App",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> createBottomSheetEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Create BottomSheet",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> createDialogEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Create Dialog",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> createServiceEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Create Service",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> createViewEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Create View",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> createWidgetEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Create Widget",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> deleteDialogEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Delete Dialog",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> deleteServiceEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Delete Service",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> deleteViewEvent({
    required String name,
    required List<String> arguments,
  }) async {
    await _capture(
      event: "Delete View",
      properties: {
        "name": name,
        "arguments": arguments,
      },
    );
  }

  Future<void> generateCodeEvent({required List<String> arguments}) async {
    await _capture(event: "Generate Code", properties: {
      "arguments": arguments,
    });
  }

  Future<void> logExceptionEvent({
    Level level = Level.error,
    required String runtimeType,
    required String message,
    String stackTrace = 'Not Available',
  }) async {
    await _capture(
      event: level.toString(),
      properties: {
        "message": '[$runtimeType] $message',
        "stackTrace": stackTrace,
      },
    );
  }

  Future<void> updateCliEvent() async {
    await _capture(event: "Update CLI");
  }
}

enum Level {
  debug,
  info,
  warning,
  error;

  @override
  String toString() {
    return 'LOG::${name.toUpperCase()}';
  }
}

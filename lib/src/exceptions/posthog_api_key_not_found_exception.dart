class PostHogApiKeyNotFoundException implements Exception {
  final String? message;

  const PostHogApiKeyNotFoundException({this.message});

  @override
  String toString() {
    final extra = message != null ? ' $message' : '';

    return 'PostHog API key not found!$extra';
  }
}

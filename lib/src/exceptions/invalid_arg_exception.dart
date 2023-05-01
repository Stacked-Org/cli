class InvalidArgException implements Exception {
  final String message;
  InvalidArgException(this.message);

  @override
  String toString() {
    return message;
  }
}

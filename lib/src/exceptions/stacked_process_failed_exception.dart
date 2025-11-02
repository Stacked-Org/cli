class StackedProcessFailedException implements Exception {
  final dynamic msg;
  StackedProcessFailedException(this.msg);

  @override
  toString() => msg.toString();
}

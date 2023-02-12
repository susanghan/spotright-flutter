class NetworkException implements Exception {
  String message;

  NetworkException(this.message);

  @override
  String toString() {
    return message;
  }
}
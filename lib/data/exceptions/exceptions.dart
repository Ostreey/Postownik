class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => 'Server exception: $message';
}

class CacheExceptions implements Exception {}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => 'Server exception: $message';
}

class InsufficientCreditFailure implements Exception {
  final String message;

  InsufficientCreditFailure(this.message);

  @override
  String toString() {
    return message;
  }
}

class CacheExceptions implements Exception {}

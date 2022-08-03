class ServerException implements Exception {}

class DatabaseException implements Exception {
  const DatabaseException(this.message);

  final String message;
}

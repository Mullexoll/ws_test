sealed class AppException implements Exception {
  AppException(this.message);
  final String message;
}

class InvalidApiKeyException extends AppException {
  InvalidApiKeyException() : super('Invalid API key');
}

sealed class APIException implements Exception {
  APIException(this.message);
  final String message;
}

class TooManyRequestException extends APIException {
  TooManyRequestException() : super('Too many request: 429');
}

class InternalServerErrorException extends APIException {
  InternalServerErrorException() : super('Internal server error: 500');
}

class UnknownException extends APIException {
  UnknownException() : super('Some error occurred');
}

class BadRequestException extends APIException {
  BadRequestException() : super('Bad request: 400');
}

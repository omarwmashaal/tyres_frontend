abstract class Failure {
  String message;
  final int? code;

  Failure({required this.message, this.code});
}

class FailureFactory {
  // Factory method to create a Failure based on the HTTP status code.
  static Failure createFailure(int statusCode, String message) {
    switch (statusCode) {
      case 400:
        return Failure_HttpBadRequest(message: "Bad Request: $message");
      case 401:
        return Failure_HttpUnauthorized(message: "UnAuthorized: $message");
      case 403:
        return Failure_HttpForbidden(message: "Forbidden: $message");
      case 404:
        return Failure_HttpNotFound(message: "Not Found: $message");
      case 500:
        return Failure_HttpInternalServerError(message: "Server Error: $message");
      case 501:
        return Failure_HttpNotImplemented(message: "UnImplemented: $message");
      case 502:
        return Failure_HttpBadGateway(message: "Bad Gatewat: $message");
      case 503:
        return Failure_HttpServiceUnavailable(message: "Service Unavailable: $message");
      default:
        // Return a generic Failure if the status code is not handled.
        return Failure_HttpUknownFailure(message: "Unknown error");
    }
  }
}

class FailureException implements Exception {
  final Failure failure;

  FailureException({required this.failure});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message}) : super(code: 400);
}

class Failure_HttpBadRequest extends Failure {
  Failure_HttpBadRequest({required super.message}) : super(code: 400);
}

class Failure_HttpUnauthorized extends Failure {
  Failure_HttpUnauthorized({required super.message}) : super(code: 401);
}

class Failure_HttpForbidden extends Failure {
  Failure_HttpForbidden({required super.message}) : super(code: 403);
}

class Failure_HttpNotFound extends Failure {
  Failure_HttpNotFound({required super.message}) : super(code: 404);
}

class Failure_HttpInternalServerError extends Failure {
  Failure_HttpInternalServerError({required super.message}) : super(code: 500);
}

class Failure_HttpNotImplemented extends Failure {
  Failure_HttpNotImplemented({required super.message}) : super(code: 501);
}

class Failure_HttpBadGateway extends Failure {
  Failure_HttpBadGateway({required super.message}) : super(code: 502);
}

class Failure_HttpServiceUnavailable extends Failure {
  Failure_HttpServiceUnavailable({required super.message}) : super(code: 503);
}

class Failure_HttpUknownFailure extends Failure {
  Failure_HttpUknownFailure({required super.message}) : super(code: 503);
}

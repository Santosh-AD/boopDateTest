class ApiResult<T> {
  final ApiStatus status;
  final T response;

  ApiResult({required this.status, required this.response});
  T get getResponse => response;

  ApiStatus get getStatus => status;
}

enum ApiStatus { success, failed, unauthorized, forbid, badRequest }

class ApiStatusCode {
  static const int SUCCESS = 200;
  static const int FORBID = 403;
  static const int UnAUTHORIZED = 401;
  static const int BADREQUEST = 400;
}

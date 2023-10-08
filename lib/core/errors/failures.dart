abstract class Failure {
  final String message;

  const Failure({required this.message});

  @override
  bool operator ==(covariant Failure other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class RouteFailure extends Failure {
  final String routeName;

  const RouteFailure(this.routeName, {required super.message});
}

class ApiError extends Failure {
  final int code;
  final dynamic data;

  const ApiError({
    required this.code,
    required super.message,
    required this.data,
  });

  factory ApiError.from(dynamic error) {
    if (error is String) {
      return ApiError(code: 0, message: error, data: error);
    }
    int code = error['errorCode'] ?? 0;
    String msg = error['message'] ?? error['msg'] ?? error['sqlMessage'];
    return ApiError(code: code, message: msg, data: error);
  }
}

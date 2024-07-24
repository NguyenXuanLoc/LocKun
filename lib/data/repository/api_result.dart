class ApiResult<T> {
  dynamic? error;
  int? statusCode;
  String? message;
  T? data;
  int? code;

  ApiResult({this.error, this.data, this.statusCode, this.message, this.code});
}

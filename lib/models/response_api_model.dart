class ResponseApiModel<T> {
  bool error;
  String message;
  T? data;

  ResponseApiModel({
    required this.error,
    this.message = '',
    this.data,
  });
}

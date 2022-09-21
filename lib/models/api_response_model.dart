class ApiResponseModel<T> {
  final T? data;
  final String? message;
  final bool error;

  ApiResponseModel.success({
    this.data,
    this.message = 'Success',
    this.error = false,
  });

  ApiResponseModel.error({
    this.data,
    this.message = 'Error',
    this.error = true,
  });
}

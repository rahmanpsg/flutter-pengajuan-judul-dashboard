import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_model.freezed.dart';
part 'api_response_model.g.dart';

@Freezed(genericArgumentFactories: true, copyWith: false)
class ApiResponseModel<T> with _$ApiResponseModel {
  const factory ApiResponseModel.success({
    T? data,
    @Default('Success') String message,
  }) = ApiResponseModelSuccess;
  const factory ApiResponseModel.error({
    @Default('Error') String message,
  }) = ApiResponseModelError;

  factory ApiResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseModelFromJson(json, fromJsonT);
}

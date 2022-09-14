// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseModelSuccess<T> _$$ApiResponseModelSuccessFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ApiResponseModelSuccess<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      message: json['message'] as String? ?? 'Success',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ApiResponseModelSuccessToJson<T>(
  _$ApiResponseModelSuccess<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'message': instance.message,
      'runtimeType': instance.$type,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

_$ApiResponseModelError<T> _$$ApiResponseModelErrorFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ApiResponseModelError<T>(
      message: json['message'] as String? ?? 'Error',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ApiResponseModelErrorToJson<T>(
  _$ApiResponseModelError<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

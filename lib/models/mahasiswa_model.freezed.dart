// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mahasiswa_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MahasiswaModel _$MahasiswaModelFromJson(Map<String, dynamic> json) {
  return _MahasiswaModel.fromJson(json);
}

/// @nodoc
mixin _$MahasiswaModel {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String? get nama => throw _privateConstructorUsedError;
  set nama(String? value) => throw _privateConstructorUsedError;
  String? get nim => throw _privateConstructorUsedError;
  set nim(String? value) => throw _privateConstructorUsedError;
  String? get angkatan => throw _privateConstructorUsedError;
  set angkatan(String? value) => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  set password(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MahasiswaModelCopyWith<MahasiswaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MahasiswaModelCopyWith<$Res> {
  factory $MahasiswaModelCopyWith(
          MahasiswaModel value, $Res Function(MahasiswaModel) then) =
      _$MahasiswaModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String? nama,
      String? nim,
      String? angkatan,
      String? password});
}

/// @nodoc
class _$MahasiswaModelCopyWithImpl<$Res>
    implements $MahasiswaModelCopyWith<$Res> {
  _$MahasiswaModelCopyWithImpl(this._value, this._then);

  final MahasiswaModel _value;
  // ignore: unused_field
  final $Res Function(MahasiswaModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? nama = freezed,
    Object? nim = freezed,
    Object? angkatan = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nama: nama == freezed
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      nim: nim == freezed
          ? _value.nim
          : nim // ignore: cast_nullable_to_non_nullable
              as String?,
      angkatan: angkatan == freezed
          ? _value.angkatan
          : angkatan // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_MahasiswaModelCopyWith<$Res>
    implements $MahasiswaModelCopyWith<$Res> {
  factory _$$_MahasiswaModelCopyWith(
          _$_MahasiswaModel value, $Res Function(_$_MahasiswaModel) then) =
      __$$_MahasiswaModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String? nama,
      String? nim,
      String? angkatan,
      String? password});
}

/// @nodoc
class __$$_MahasiswaModelCopyWithImpl<$Res>
    extends _$MahasiswaModelCopyWithImpl<$Res>
    implements _$$_MahasiswaModelCopyWith<$Res> {
  __$$_MahasiswaModelCopyWithImpl(
      _$_MahasiswaModel _value, $Res Function(_$_MahasiswaModel) _then)
      : super(_value, (v) => _then(v as _$_MahasiswaModel));

  @override
  _$_MahasiswaModel get _value => super._value as _$_MahasiswaModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? nama = freezed,
    Object? nim = freezed,
    Object? angkatan = freezed,
    Object? password = freezed,
  }) {
    return _then(_$_MahasiswaModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nama: nama == freezed
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      nim: nim == freezed
          ? _value.nim
          : nim // ignore: cast_nullable_to_non_nullable
              as String?,
      angkatan: angkatan == freezed
          ? _value.angkatan
          : angkatan // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MahasiswaModel implements _MahasiswaModel {
  _$_MahasiswaModel(
      {required this.id, this.nama, this.nim, this.angkatan, this.password});

  factory _$_MahasiswaModel.fromJson(Map<String, dynamic> json) =>
      _$$_MahasiswaModelFromJson(json);

  @override
  String id;
  @override
  String? nama;
  @override
  String? nim;
  @override
  String? angkatan;
  @override
  String? password;

  @override
  String toString() {
    return 'MahasiswaModel(id: $id, nama: $nama, nim: $nim, angkatan: $angkatan, password: $password)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_MahasiswaModelCopyWith<_$_MahasiswaModel> get copyWith =>
      __$$_MahasiswaModelCopyWithImpl<_$_MahasiswaModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MahasiswaModelToJson(
      this,
    );
  }
}

abstract class _MahasiswaModel implements MahasiswaModel {
  factory _MahasiswaModel(
      {required String id,
      String? nama,
      String? nim,
      String? angkatan,
      String? password}) = _$_MahasiswaModel;

  factory _MahasiswaModel.fromJson(Map<String, dynamic> json) =
      _$_MahasiswaModel.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String? get nama;
  set nama(String? value);
  @override
  String? get nim;
  set nim(String? value);
  @override
  String? get angkatan;
  set angkatan(String? value);
  @override
  String? get password;
  set password(String? value);
  @override
  @JsonKey(ignore: true)
  _$$_MahasiswaModelCopyWith<_$_MahasiswaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

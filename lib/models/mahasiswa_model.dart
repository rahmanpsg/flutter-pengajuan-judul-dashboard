import 'package:freezed_annotation/freezed_annotation.dart';

part 'mahasiswa_model.freezed.dart';
part 'mahasiswa_model.g.dart';

@unfreezed
class MahasiswaModel with _$MahasiswaModel {
  factory MahasiswaModel({
    String? id,
    String? nama,
    String? nim,
    String? angkatan,
    String? password,
  }) = _MahasiswaModel;

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) =>
      _$MahasiswaModelFromJson(json);
}

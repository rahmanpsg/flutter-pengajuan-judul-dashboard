import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

class MahasiswaModel {
  String id;
  String? nama;
  String? nim;
  String? angkatan;
  String? password;

  MahasiswaModel({
    String? id,
    this.nama,
    this.nim,
    this.angkatan,
    this.password,
  }) : id = id ?? const Uuid().v4();

  @override
  String toString() {
    return 'MahasiswaModel(id: $id, nama: $nama, nim: $nim, angkatan: $angkatan, password: $password)';
  }

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      id: json['id'] as String?,
      nama: json['nama'] as String?,
      nim: json['nim'] as String?,
      angkatan: json['angkatan'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'nim': nim,
        'angkatan': angkatan,
        'password': password,
      };

  MahasiswaModel copyWith({
    String? id,
    String? nama,
    String? nim,
    String? angkatan,
    String? password,
  }) {
    return MahasiswaModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      nim: nim ?? this.nim,
      angkatan: angkatan ?? this.angkatan,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MahasiswaModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nama.hashCode ^
      nim.hashCode ^
      angkatan.hashCode ^
      password.hashCode;
}

import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

class DosenModel {
  String id;
  String? nama;
  String? nbm;
  String? jabatan;

  DosenModel({
    String? id,
    this.nama,
    this.nbm,
    this.jabatan,
  }) : id = id ?? const Uuid().v4();

  @override
  String toString() {
    return 'DosenModel(id: $id, nama: $nama, nbm: $nbm, jabatan: $jabatan)';
  }

  factory DosenModel.fromJson(Map<String, dynamic> json) => DosenModel(
        id: json['id'] as String?,
        nama: json['nama'] as String?,
        nbm: json['nbm'] as String?,
        jabatan: json['jabatan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'nbm': nbm,
        'jabatan': jabatan,
      };

  DosenModel copyWith({
    String? id,
    String? nama,
    String? nbm,
    String? jabatan,
  }) {
    return DosenModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      nbm: nbm ?? this.nbm,
      jabatan: jabatan ?? this.jabatan,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DosenModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^ nama.hashCode ^ nbm.hashCode ^ jabatan.hashCode;
}

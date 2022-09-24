import 'package:collection/collection.dart';
import 'package:pengajuan_judul_dashboard/models/file_data_model.dart';
import 'package:uuid/uuid.dart';

class JudulModel {
  String id;
  String? judul;
  FileDataModel? fileData;
  bool? status;
  double? deteksi;
  DateTime? tanggal;
  String? mahasiswaId;
  List<String>? pembimbingIds;

  JudulModel({
    String? id,
    this.judul,
    this.fileData,
    this.status,
    this.deteksi,
    DateTime? tanggal,
    this.mahasiswaId,
    this.pembimbingIds,
  })  : id = id ?? const Uuid().v4(),
        tanggal = tanggal ?? DateTime.now();

  @override
  String toString() {
    return 'JudulModel(id: $id, judul: $judul, fileData: $fileData, status: $status, deteksi: $deteksi, tanggal: $tanggal)';
  }

  factory JudulModel.fromJson(Map<String, dynamic> json) => JudulModel(
        id: json['id'] as String?,
        judul: json['judul'] as String?,
        fileData: json['fileData'] != null
            ? FileDataModel.fromJson(json['fileData'])
            : null,
        status: json['status'] as bool?,
        deteksi: (json['deteksi'] as num?)?.toDouble(),
        // tanggal: (json['tanggal']) as DateTime?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        if (fileData != null) 'fileData': fileData?.toJson(),
        'status': status,
        'tanggal': tanggal,
        if (deteksi != null) 'deteksi': deteksi,
        if (mahasiswaId != null) 'mahasiswaId': mahasiswaId,
        if (pembimbingIds != null) 'pembimbingIds': pembimbingIds,
      };

  JudulModel copyWith({
    String? id,
    String? judul,
    FileDataModel? fileData,
    bool? status,
    double? deteksi,
    DateTime? tanggal,
    String? mahasiswaId,
    List<String>? pembimbingIds,
  }) {
    return JudulModel(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      fileData: fileData ?? this.fileData,
      status: status ?? this.status,
      deteksi: deteksi ?? this.deteksi,
      tanggal: tanggal ?? this.tanggal,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      pembimbingIds: pembimbingIds ?? this.pembimbingIds,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! JudulModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      judul.hashCode ^
      status.hashCode ^
      tanggal.hashCode ^
      deteksi.hashCode;
}

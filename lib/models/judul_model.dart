import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:pengajuan_judul_dashboard/models/file_data_model.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';
import 'package:uuid/uuid.dart';

class JudulModel {
  String id;
  String? judul;
  FileDataModel? fileData;
  bool? status;
  double? deteksi;
  String? mahasiswaId;
  List<String>? pembimbingIds;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  JudulModel({
    String? id,
    this.judul,
    this.fileData,
    this.status,
    this.deteksi,
    this.mahasiswaId,
    this.pembimbingIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        _createdAt = createdAt ?? DateTime.now(),
        _updatedAt = updatedAt ?? DateTime.now();

  @override
  String toString() {
    return 'JudulModel(id: $id, judul: $judul, fileData: $fileData, status: $status, deteksi: $deteksi, mahasiswaId: $mahasiswaId, createdAt: $_createdAt, updatedAt: $_updatedAt)';
  }

  factory JudulModel.fromJson(Map<String, dynamic> json) => JudulModel(
        id: json['id'] as String?,
        judul: json['judul'] as String?,
        fileData: json['fileData'] != null
            ? FileDataModel.fromJson(json['fileData'])
            : null,
        status: json['status'] as bool?,
        deteksi: (json['deteksi'] as num?)?.toDouble(),
        mahasiswaId: json['mahasiswaId'] as String?,
        pembimbingIds: json['pembimbingIds'] as List<String>?,
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        if (fileData != null) 'fileData': fileData?.toJson(),
        'status': status,
        if (deteksi != null) 'deteksi': deteksi,
        if (mahasiswaId != null) 'mahasiswaId': mahasiswaId,
        if (pembimbingIds != null) 'pembimbingIds': pembimbingIds,
        'createdAt': _createdAt?.millisecondsSinceEpoch,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      };

  JudulModel copyWith({
    String? id,
    String? judul,
    FileDataModel? fileData,
    bool? status,
    double? deteksi,
    String? mahasiswaId,
    List<String>? pembimbingIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JudulModel(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      fileData: fileData ?? this.fileData,
      status: status ?? this.status,
      deteksi: deteksi ?? this.deteksi,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      pembimbingIds: pembimbingIds ?? this.pembimbingIds,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
    );
  }

  String get statusString => status == null
      ? 'Belum diverifikasi'
      : status == true
          ? 'Diterima'
          : 'Ditolak';

  Color get statusColor => status == null
      ? yellowColor
      : status == true
          ? greenColor
          : dangerColor;

  String get tanggalFormat => DateFormat('dd/MM/yyyy').format(_createdAt!);
  String get tanggalUploadFormat =>
      DateFormat('EEEE, dd MMMM yyyy hh:mm a').format(_createdAt!);

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
      mahasiswaId.hashCode ^
      _createdAt.hashCode ^
      _updatedAt.hashCode ^
      deteksi.hashCode;
}

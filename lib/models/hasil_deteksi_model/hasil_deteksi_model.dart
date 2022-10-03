import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_colors.dart';

import 'hasil_tfidf.dart';

class HasilDeteksiModel {
  String? judul;
  double? jarak;
  double? similarity;
  List<HasilTfidf>? hasilTfidf;

  HasilDeteksiModel({
    this.judul,
    this.jarak,
    this.similarity,
    this.hasilTfidf,
  });

  @override
  String toString() {
    return 'HasilDeteksiModel(judul: $judul, jarak: $jarak, similarity: $similarity, hasilTfidf: $hasilTfidf)';
  }

  factory HasilDeteksiModel.fromJson(Map<String, dynamic> json) {
    return HasilDeteksiModel(
      judul: json['judul'] as String?,
      jarak: json['jarak'] as double?,
      similarity: (json['similarity'] as num?)?.toDouble(),
      hasilTfidf: (json['hasil_tfidf'] as List<dynamic>?)
          ?.map((e) => HasilTfidf.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'judul': judul,
        'jarak': jarak,
        'similarity': similarity,
        'hasil_tfidf': hasilTfidf?.map((e) => e.toJson()).toList(),
      };

  double get persentase => similarity! * 100 > 100 ? 100 : similarity! * 100;

  Color? get persentaseColor =>
      Color.lerp(greenColor, dangerColor, similarity!);
}

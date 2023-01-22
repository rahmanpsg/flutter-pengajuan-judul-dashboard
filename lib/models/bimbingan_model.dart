import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';

class BimbinganModel {
  final JudulModel judul;
  final MahasiswaModel mahasiswa;
  final int pembimbing;

  BimbinganModel({
    required this.judul,
    required this.mahasiswa,
    required this.pembimbing,
  });
}

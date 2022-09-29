import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';
import 'package:pengajuan_judul_dashboard/enums/judul_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/models/dosen_model.dart';
import 'package:pengajuan_judul_dashboard/models/hasil_deteksi_model/hasil_deteksi_model.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:pengajuan_judul_dashboard/services/judul_service.dart';
import 'package:pengajuan_judul_dashboard/services/mahasiswa_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../services/dosen_service.dart';
import 'judul_dialog_view.dart';

class JudulDialogViewModel extends CustomBaseViewModel {
  final log = getLogger("JudulDialogViewModel");

  final _mahasiswaService = locator<MahasiswaService>();
  final _dosenService = locator<DosenService>();
  final _judulService = locator<JudulService>();

  int get totalDataSet =>
      _judulService.list.where((x) => x.status == true).length;

  final formKey = GlobalKey<FormState>();

  late final Function(DialogResponse) completer;
  late final JudulModel judul;

  MahasiswaModel? mahasiswa;
  List<DosenModel> pembimbings = [];

  JudulDialogType type = JudulDialogType.details;

  late List<HasilDeteksiModel> hasilDeteksiList;

  Future<void> init(
      Function(DialogResponse) completer, JudulDialogData data) async {
    this.completer = completer;
    judul = data.judul;

    if (judul.mahasiswaId != null) {
      mahasiswa = _mahasiswaService.get(judul.mahasiswaId!);
    }

    if (judul.pembimbingIds?.isNotEmpty == true) {
      for (var id in judul.pembimbingIds!) {
        final pembimbing = _dosenService.get(id);

        if (pembimbing != null) {
          pembimbings.add(pembimbing);
        }
      }
    }
  }

  void changeJudulDialogType(JudulDialogType type) {
    this.type = type;
    notifyListeners();
  }

  void onDownloadDocument() async {
    // TODO: implement this
  }

  void onDeteksi(String K) async {
    if (formKey.currentState?.validate() != true) return;

    setBusy(true);

    try {
      int k = int.parse(K);

      hasilDeteksiList = await _judulService.deteksi(judul, k);

      type = JudulDialogType.hasilDeteksi;
    } catch (e) {
      log.e(e);
    }

    setBusy(false);
  }
}

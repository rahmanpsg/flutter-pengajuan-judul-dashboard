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
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/widgets/details_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/widgets/hasil_deteksi_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/widgets/initial_deteksi_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/widgets/terima_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/widgets/tolak_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<DosenModel> get pembimbings => _dosenService.list;

  final formKey = GlobalKey<FormState>();

  late final Function(DialogResponse) completer;
  late final JudulModel judul;

  MahasiswaModel? mahasiswa;
  DosenModel? pembimbing1;
  DosenModel? pembimbing2;

  JudulDialogType type = JudulDialogType.details;

  Widget get view => [
        const DetailsView(),
        const InitialDeteksiView(),
        const HasilDeteksiView(),
        const TolakView(),
        const TerimaView(),
      ][type.index];

  late List<HasilDeteksiModel> hasilDeteksiList;

  Future<void> init(
      Function(DialogResponse) completer, JudulDialogData data) async {
    this.completer = completer;
    judul = data.judul;

    if (judul.mahasiswaId != null) {
      mahasiswa = _mahasiswaService.get(judul.mahasiswaId!);
    }

    if (judul.pembimbing1 != null) {
      pembimbing1 = _dosenService.get(judul.pembimbing1!);
    }

    if (judul.pembimbing2 != null) {
      pembimbing2 = _dosenService.get(judul.pembimbing2!);
    }
  }

  void changeJudulDialogType(JudulDialogType type) {
    this.type = type;
    notifyListeners();
  }

  void onDownloadDocument() async {
    try {
      final url = Uri.parse(judul.fileData!.url!);

      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      log.e(e);
      dialogService.showDialog(
        title: 'Informasi',
        description: 'File tidak ditemukan',
        dialogPlatform: DialogPlatform.Material,
      );
    }
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

  void onTolak({String? koreksi}) async {
    if (formKey.currentState?.validate() != true) return;

    judul.status = false;
    judul.koreksi = koreksi;

    setBusy(true);

    try {
      await _judulService.save(judul);

      navigationService.back();

      await dialogService.showDialog(
        title: 'Informasi',
        description: 'Judul berhasil ditolak',
        dialogPlatform: DialogPlatform.Material,
      );
    } catch (e) {
      log.e(e);

      dialogService.showDialog(
        title: 'Informasi',
        description: e.toString(),
        dialogPlatform: DialogPlatform.Material,
      );
    }

    setBusy(false);
  }

  void onTerima({
    String? pembimbing1ID,
    String? pembimbing2ID,
  }) async {
    if (formKey.currentState?.validate() != true) return;

    judul.status = true;
    judul.pembimbing1 = pembimbing1ID;
    judul.pembimbing2 = pembimbing2ID;

    setBusy(true);

    try {
      await _judulService.save(judul);

      navigationService.back();

      await dialogService.showDialog(
        title: 'Informasi',
        description: 'Judul berhasil diterima',
        dialogPlatform: DialogPlatform.Material,
      );
    } catch (e) {
      log.e(e);

      dialogService.showDialog(
        title: 'Informasi',
        description: e.toString(),
        dialogPlatform: DialogPlatform.Material,
      );
    }

    setBusy(false);
  }
}

import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';
import 'package:pengajuan_judul_dashboard/models/bimbingan_model.dart';
import 'package:pengajuan_judul_dashboard/models/dosen_model.dart';
import 'package:pengajuan_judul_dashboard/ui/views/dosen/daftar_bimbingan_dialog/daftar_bimbingan_dialog_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.logger.dart';
import '../../../../models/judul_model.dart';
import '../../../../services/judul_service.dart';
import '../../../../services/mahasiswa_service.dart';

class DaftarBimbinganDialogViewModel extends CustomBaseViewModel {
  final log = getLogger("DaftarBimbinganDialogViewModel");

  final _judulService = locator<JudulService>();
  final _mahasiswaService = locator<MahasiswaService>();

  late final DosenModel dosen;

  final list = <BimbinganModel>[];

  Future<void> init(DaftarBimbinganDialogData data) async {
    setBusy(true);

    try {
      dosen = data.dosen;

      final juduls = _judulService.getByPembimbing(dosen);

      for (var judul in juduls) {
        final mahasiswa = _mahasiswaService.get(judul.mahasiswaId!);

        final pembimbing = judul.pembimbing1 == dosen.id ? 1 : 2;

        final bimbingan = BimbinganModel(
          judul: judul,
          mahasiswa: mahasiswa!,
          pembimbing: pembimbing,
        );

        list.add(bimbingan);
      }
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
  }

  void onDownloadDocument(String urlJudul) async {
    try {
      final url = Uri.parse(urlJudul);

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
}

import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.logger.dart';
import '../../../../services/judul_service.dart';
import 'daftar_judul_dialog_view.dart';

class DaftarJudulDialogViewModel extends CustomBaseViewModel {
  final log = getLogger("DaftarJudulDialogViewModel");

  final _judulService = locator<JudulService>();

  late final MahasiswaModel mahasiswa;

  final juduls = <JudulModel>[];

  Future<void> init(DaftarJudulDialogData data) async {
    mahasiswa = data.mahasiswa;

    final juduls = _judulService.getByMahasiswa(mahasiswa);

    this.juduls.addAll(juduls);
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

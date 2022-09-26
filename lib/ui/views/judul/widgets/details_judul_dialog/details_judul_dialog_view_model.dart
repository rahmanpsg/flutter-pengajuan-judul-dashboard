import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';
import 'package:pengajuan_judul_dashboard/models/dosen_model.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:pengajuan_judul_dashboard/services/mahasiswa_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../services/dosen_service.dart';
import 'details_judul_dialog_view.dart';

class DetailsJudulDialogViewModel extends CustomBaseViewModel {
  final log = getLogger("DetailsJudulDialogViewModel");

  final _mahasiswaService = locator<MahasiswaService>();
  final _dosenService = locator<DosenService>();

  late final Function(DialogResponse) completer;
  late final JudulModel judul;

  MahasiswaModel? mahasiswa;
  List<DosenModel> pembimbings = [];

  Future<void> init(
      Function(DialogResponse) completer, DetailsJudulDialogData data) async {
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

  void onDownloadDocument() async {}
}

import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';

import '../../../app/app.locator.dart';
import '../../../services/mahasiswa_service.dart';

class HomeViewModel extends CustomBaseViewModel {
  final log = getLogger("HomeViewModel");

  final _mahasiswaService = locator<MahasiswaService>();

  String get totalMahasiswa => _mahasiswaService.list.length.toString();

  Future<void> init() async {}
}

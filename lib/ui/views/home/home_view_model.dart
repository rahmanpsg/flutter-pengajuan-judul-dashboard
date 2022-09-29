import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/judul_service.dart';
import '../../../services/mahasiswa_service.dart';

class HomeViewModel extends ReactiveViewModel {
  final log = getLogger("HomeViewModel");

  final _mahasiswaService = locator<MahasiswaService>();
  final _judulService = locator<JudulService>();

  String get totalMahasiswa => _mahasiswaService.list.length.toString();
  String get totalJudul => _judulService.list.length.toString();
  String get totalDiterima =>
      _judulService.list.where((x) => x.status == true).length.toString();
  String get totalDitolak =>
      _judulService.list.where((x) => x.status == false).length.toString();

  Future<void> init() async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_mahasiswaService, _judulService];
}

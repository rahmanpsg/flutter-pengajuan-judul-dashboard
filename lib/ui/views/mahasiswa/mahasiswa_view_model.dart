import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialog.dart';
import '../../../app/app.locator.dart';
import '../../../enums/form_dialog_type.dart';
import '../../../models/mahasiswa_model.dart';
import '../../../services/mahasiswa_service.dart';
import 'widgets/form_mahasiswa_dialog/form_mahasiswa_dialog_view.dart';

class MahasiswaViewModel extends ReactiveViewModel {
  final log = getLogger("MahasiswaViewModel");

  final _dialogService = locator<DialogService>();
  final _mahasiswaService = locator<MahasiswaService>();

  List<MahasiswaModel> get list => _mahasiswaService.list;

  Future<void> init() async {}

  /// [mahasiswa] set null if you need to add new the data
  void onAddOrEdit(MahasiswaModel? mahasiswa) async {
    bool isEdit = mahasiswa != null;

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.formMahasiswaDialogView,
      data: FormMahasiswaDialogData(
        type: isEdit ? FormDialogType.edit : FormDialogType.add,
        mahasiswa: mahasiswa,
      ),
      title: '${isEdit ? 'Edit' : 'Tambah'} Data Mahasiswa',
    );

    log.d("response: ${response?.data}");

    if (response?.confirmed != true) return;

    setBusy(true);

    final result = await _mahasiswaService.save(response!.data);

    log.d("result: $result");

    setBusy(false);
  }

  void onDelete(MahasiswaModel mahasiswa) async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Informasi',
      description:
          'Anda yakin untuk menghapus data mahasiswa ${mahasiswa.nama} ${mahasiswa.nim}?',
      dialogPlatform: DialogPlatform.Material,
    );

    if (response?.confirmed != true) return;

    final result = await _mahasiswaService.delete(mahasiswa.id);

    log.d("result: $result");
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_mahasiswaService];
}

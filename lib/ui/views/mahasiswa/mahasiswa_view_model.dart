import '../../../app/app.dialog.dart';
import '../../../app/core/custom_base_view_model.dart';
import '../../../enums/form_dialog_type.dart';
import '../../shared/form_mahasiswa_dialog/form_mahasiswa_dialog_view.dart';

class MahasiswaViewModel extends CustomBaseViewModel {
  Future<void> init() async {}

  void onAddData() async {
    final response = await dialogService.showCustomDialog(
      variant: DialogType.formMahasiswaDialogView,
      data: FormMahasiswaDialogData(type: FormDialogType.add),
      title: 'Tambah Data Mahasiswa',
    );
  }
}

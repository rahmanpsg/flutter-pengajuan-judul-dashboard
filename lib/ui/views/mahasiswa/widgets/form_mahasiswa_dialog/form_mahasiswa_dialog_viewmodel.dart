import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/app.dialog.dart';
import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:pengajuan_judul_dashboard/ui/shared/year_picker_dialog/year_picker_dialog_view.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../../app/app.logger.dart';
import '../../../../../enums/form_dialog_type.dart';
import 'form_mahasiswa_dialog_view.dart';

class FormMahasiswaDialogViewModel extends CustomBaseViewModel {
  final log = getLogger('FormMahasiswaDialogViewModel');

  final formKey = GlobalKey<FormState>();

  late final Function(DialogResponse) completer;

  bool hidePassword = true;

  late final FormDialogType type;
  late final MahasiswaModel mahasiswa;

  void init(Function(DialogResponse) completer, FormMahasiswaDialogData data) {
    this.completer = completer;
    type = data.type;
    mahasiswa = data.mahasiswa ?? MahasiswaModel();
  }

  Future openAngkatanDialog(TextEditingController controller) async {
    final response = await dialogService.showCustomDialog(
        variant: DialogType.yearPickerDialogView,
        data: YearPickerDialogData(
          selectedDate: mahasiswa.angkatan != null
              ? DateTime(int.parse(mahasiswa.angkatan!))
              : DateTime.now(),
        ),
        title: 'Pilih tahun angkatan');

    if (response?.data == null) return;

    log.d("response: ${response?.data}");

    mahasiswa.angkatan = (response?.data as DateTime).year.toString();
    controller.text = mahasiswa.angkatan ?? '';
  }

  void onCancel() async {
    completer(
      DialogResponse(
        confirmed: false,
      ),
    );
  }

  void onSubmit() async {
    if (formKey.currentState?.validate() != true) return;

    if (isBusy) return;

    setBusy(true);

    completer(
      DialogResponse(
        confirmed: true,
        data: mahasiswa,
      ),
    );

    setBusy(false);
  }
}

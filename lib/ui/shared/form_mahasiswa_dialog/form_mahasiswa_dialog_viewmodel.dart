import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app.logger.dart';
import '../../../enums/form_dialog_type.dart';
import 'form_mahasiswa_dialog_view.dart';

class FormMahasiswaDialogViewModel extends BaseViewModel {
  final log = getLogger('FormMahasiswaDialogViewModel');

  final formKey = GlobalKey<FormState>();

  late final Function(DialogResponse) completer;

  bool hidePassword = true;

  late final FormDialogType type;
  late final MahasiswaModel mahasiswa;

  String? errorMessage;

  final TextEditingController searchController = TextEditingController();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController angkatanController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void init(Function(DialogResponse) completer, FormMahasiswaDialogData data) {
    this.completer = completer;
    type = data.type;
    mahasiswa = data.mahasiswa ?? MahasiswaModel(id: const Uuid().v4());

    namaController.text = mahasiswa.nama ?? '';
    nimController.text = mahasiswa.nim ?? '';
    angkatanController.text = mahasiswa.angkatan ?? '';
    passwordController.text = mahasiswa.password ?? '';

    namaController.addListener(() {
      mahasiswa.nama = namaController.text;
    });
    nimController.addListener(() {
      mahasiswa.nim = nimController.text;
    });

    passwordController.addListener(() {
      mahasiswa.password = passwordController.text;
    });
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

  @override
  void dispose() {
    searchController.dispose();
    namaController.dispose();
    nimController.dispose();
    angkatanController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}

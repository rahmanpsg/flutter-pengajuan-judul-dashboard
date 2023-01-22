// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../ui/shared/year_picker_dialog/year_picker_dialog_view.dart';
import '../ui/views/dosen/daftar_bimbingan_dialog/daftar_bimbingan_dialog_view.dart';
import '../ui/views/dosen/form_dosen_dialog/form_dosen_dialog_view.dart';
import '../ui/views/judul/widgets/form_judul_dialog/form_judul_dialog_view.dart';
import '../ui/views/judul/widgets/judul_dialog/judul_dialog_view.dart';
import '../ui/views/mahasiswa/daftar_judul_dialog/daftar_judul_dialog_view.dart';
import '../ui/views/mahasiswa/widgets/form_mahasiswa_dialog/form_mahasiswa_dialog_view.dart';

enum DialogType {
  yearPickerDialogView,
  formMahasiswaDialogView,
  formDosenDialogView,
  formJudulDialogView,
  judulDialogView,
  daftarJudulDialogView,
  daftarBimbinganDialogView,
}

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
    DialogType.yearPickerDialogView: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        YearPickerDialogView(request: request, completer: completer),
    DialogType.formMahasiswaDialogView: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        FormMahasiswaDialogView(request: request, completer: completer),
    DialogType.formDosenDialogView: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        FormDosenDialogView(request: request, completer: completer),
    DialogType.formJudulDialogView: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        FormJudulDialogView(request: request, completer: completer),
    DialogType.judulDialogView: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        JudulDialogView(request: request, completer: completer),
    DialogType.daftarJudulDialogView: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        DaftarJudulDialogView(request: request, completer: completer),
    DialogType.daftarBimbinganDialogView: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        DaftarBimbinganDialogView(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

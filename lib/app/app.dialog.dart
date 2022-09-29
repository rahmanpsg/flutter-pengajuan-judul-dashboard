// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../ui/shared/year_picker_dialog/year_picker_dialog_view.dart';
import '../ui/views/dosen/widgets/form_dosen_dialog/form_dosen_dialog_view.dart';
import '../ui/views/judul/widgets/form_judul_dialog/form_judul_dialog_view.dart';
import '../ui/views/judul/widgets/judul_dialog/judul_dialog_view.dart';
import '../ui/views/mahasiswa/widgets/form_mahasiswa_dialog/form_mahasiswa_dialog_view.dart';

enum DialogType {
  yearPickerDialogView,
  formMahasiswaDialogView,
  formDosenDialogView,
  formJudulDialogView,
  judulDialogView,
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
  };

  dialogService.registerCustomDialogBuilders(builders);
}

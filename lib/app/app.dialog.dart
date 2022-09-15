// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../ui/shared/form_mahasiswa_dialog/form_mahasiswa_dialog_view.dart';

enum DialogType {
  formMahasiswaDialogView,
}

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
    DialogType.formMahasiswaDialogView: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        FormMahasiswaDialogView(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';
import 'package:pengajuan_judul_dashboard/enums/form_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/models/dosen_model.dart';
import 'package:pengajuan_judul_dashboard/ui/views/dosen/widgets/form_dosen_dialog/form_dosen_dialog_view.dart';
import 'package:stacked_services/stacked_services.dart';

class FormDosenDialogViewModel extends CustomBaseViewModel {
  final log = getLogger('FormDosenDialogViewModel');

  final formKey = GlobalKey<FormState>();

  late final Function(DialogResponse) completer;

  bool hidePassword = true;

  late final FormDialogType type;
  late final DosenModel dosen;

  void init(Function(DialogResponse) completer, FormDosenDialogData data) {
    this.completer = completer;
    type = data.type;
    dosen = data.dosen ?? DosenModel();
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
        data: dosen,
      ),
    );

    setBusy(false);
  }
}

import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:pengajuan_judul_dashboard/themes/app_text.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_textfield_outline.dart';
import 'package:pengajuan_judul_dashboard/utils/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import '../../../enums/form_dialog_type.dart';
import '../../../themes/app_colors.dart';
import 'form_mahasiswa_dialog_viewmodel.dart';

class FormMahasiswaDialogData {
  final FormDialogType type;
  final MahasiswaModel? mahasiswa;

  FormMahasiswaDialogData({
    required this.type,
    this.mahasiswa,
  });
}

class FormMahasiswaDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const FormMahasiswaDialogView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormMahasiswaDialogViewModel>.reactive(
      viewModelBuilder: () => FormMahasiswaDialogViewModel(),
      onModelReady: (model) => model.init(completer, request.data!),
      builder: (
        BuildContext context,
        FormMahasiswaDialogViewModel model,
        Widget? child,
      ) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: model.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      request.title ?? "",
                      style: boldTextStyle.copyWith(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Silahkan lengkapi data berikut",
                    ),
                    const SizedBox(height: 32),
                    CustomTextFieldOutline(
                      controller: model.namaController,
                      prefixIcon: const Icon(
                        UniconsLine.user,
                        color: secondaryColor,
                      ),
                      hintText: 'Nama',
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          Validator.validateEmpty(value: val, field: 'nama'),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldOutline(
                      controller: model.nimController,
                      prefixIcon: const Icon(
                        UniconsLine.postcard,
                        color: secondaryColor,
                      ),
                      hintText: 'NIM',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          Validator.validateEmpty(value: val, field: 'nim'),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldOutline(
                      controller: model.angkatanController,
                      focusNode: model.angkatanFieldFocusNode,
                      onTap: model.openAngkatanDialog,
                      prefixIcon: const Icon(
                        UniconsLine.calendar_alt,
                        color: secondaryColor,
                      ),
                      hintText: 'Angkatan',
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (val) => Validator.validateEmpty(
                          value: val, field: 'angkatan'),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldOutline(
                      controller: model.passwordController,
                      prefixIcon: const Icon(
                        UniconsLine.lock,
                        color: secondaryColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          model.hidePassword = !model.hidePassword;
                          model.notifyListeners();
                        },
                        child: Icon(model.hidePassword
                            ? UniconsLine.eye
                            : UniconsLine.eye_slash),
                      ),
                      hintText: 'Password',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: model.hidePassword,
                      validator: (val) => Validator.validateEmpty(
                          value: val, field: 'password'),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(UniconsLine.times_circle),
                            label: const Text('Batal'),
                            onPressed: model.isBusy
                                ? null
                                : () {
                                    completer(
                                      DialogResponse(
                                        confirmed: false,
                                      ),
                                    );
                                  },
                            style: OutlinedButton.styleFrom(
                              primary: dangerColor,
                              side: const BorderSide(
                                color: dangerColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: model.isBusy
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : const Icon(
                                    UniconsLine.check_circle,
                                  ),
                            label: Text(request.data?.type == FormDialogType.add
                                ? 'Simpan'
                                : 'Ubah'),
                            onPressed: model.isBusy ? null : model.onSubmit,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

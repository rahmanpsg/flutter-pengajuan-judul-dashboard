import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:pengajuan_judul_dashboard/themes/app_text.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_textfield_outline.dart';
import 'package:pengajuan_judul_dashboard/utils/string.dart';
import 'package:pengajuan_judul_dashboard/utils/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import '../../../../../enums/form_dialog_type.dart';
import '../../../../../themes/app_colors.dart';
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
    return ViewModelBuilder<FormMahasiswaDialogViewModel>.nonReactive(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const _HookForm(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HookForm extends HookViewModelWidget<FormMahasiswaDialogViewModel> {
  const _HookForm({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
      BuildContext context, FormMahasiswaDialogViewModel viewModel) {
    final namaController =
        useTextEditingController(text: viewModel.mahasiswa.nama);
    final nimController =
        useTextEditingController(text: viewModel.mahasiswa.nim);
    final angkatanController =
        useTextEditingController(text: viewModel.mahasiswa.angkatan);
    final passwordController =
        useTextEditingController(text: viewModel.mahasiswa.password);

    final angkatanFocus = useFocusNode();

    useEffect(() {
      angkatanFocus.addListener(() async {
        if (angkatanFocus.hasFocus &&
            viewModel.mahasiswa.angkatan?.isNotEmpty != true) {
          viewModel.openAngkatanDialog(angkatanController);
        }
      });

      return;
    });

    return Form(
      key: viewModel.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextFieldOutline(
            controller: namaController,
            onChanged: (val) {
              viewModel.mahasiswa.nama = val.toTitleCase();
            },
            prefixIcon: const Icon(
              UniconsLine.user,
              color: secondaryColor,
            ),
            hintText: 'Nama*',
            textInputAction: TextInputAction.next,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'nama'),
          ),
          const SizedBox(height: 16),
          CustomTextFieldOutline(
            controller: nimController,
            onChanged: (val) {
              viewModel.mahasiswa.nim = val;
            },
            prefixIcon: const Icon(
              UniconsLine.postcard,
              color: secondaryColor,
            ),
            hintText: 'NIM*',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'nim'),
          ),
          const SizedBox(height: 16),
          CustomTextFieldOutline(
            controller: angkatanController,
            focusNode: angkatanFocus,
            onTap: () => viewModel.openAngkatanDialog(angkatanController),
            prefixIcon: const Icon(
              UniconsLine.calendar_alt,
              color: secondaryColor,
            ),
            hintText: 'Angkatan*',
            readOnly: true,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'angkatan'),
          ),
          const SizedBox(height: 16),
          CustomTextFieldOutline(
            controller: passwordController,
            onChanged: (val) {
              viewModel.mahasiswa.password = val;
            },
            prefixIcon: const Icon(
              UniconsLine.lock,
              color: secondaryColor,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                viewModel.hidePassword = !viewModel.hidePassword;
                viewModel.notifyListeners();
              },
              child: Icon(viewModel.hidePassword
                  ? UniconsLine.eye
                  : UniconsLine.eye_slash),
            ),
            hintText: 'Password*',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            obscureText: viewModel.hidePassword,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'password'),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(UniconsLine.times_circle),
                  label: const Text('Batal'),
                  onPressed: viewModel.isBusy ? null : viewModel.onCancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: dangerColor,
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
                  icon: viewModel.isBusy
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(
                          UniconsLine.check_circle,
                        ),
                  label: Text(
                      viewModel.type == FormDialogType.add ? 'Simpan' : 'Ubah'),
                  onPressed: viewModel.isBusy ? null : viewModel.onSubmit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

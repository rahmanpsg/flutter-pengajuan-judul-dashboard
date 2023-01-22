import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pengajuan_judul_dashboard/models/dosen_model.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_text.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_textfield_outline.dart';
import 'package:pengajuan_judul_dashboard/utils/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import '../../../../enums/form_dialog_type.dart';
import './form_dosen_dialog_view_model.dart';

class FormDosenDialogData {
  final FormDialogType type;
  final DosenModel? dosen;

  FormDosenDialogData({
    required this.type,
    this.dosen,
  });
}

class FormDosenDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const FormDosenDialogView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormDosenDialogViewModel>.nonReactive(
      viewModelBuilder: () => FormDosenDialogViewModel(),
      onModelReady: (FormDosenDialogViewModel model) async {
        model.init(completer, request.data);
      },
      builder: (
        BuildContext context,
        FormDosenDialogViewModel model,
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

class _HookForm extends HookViewModelWidget<FormDosenDialogViewModel> {
  const _HookForm({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
      BuildContext context, FormDosenDialogViewModel viewModel) {
    final namaController = useTextEditingController(text: viewModel.dosen.nama);
    final nbmController = useTextEditingController(text: viewModel.dosen.nbm);
    final jabatanController =
        useTextEditingController(text: viewModel.dosen.jabatan);

    return Form(
      key: viewModel.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextFieldOutline(
            controller: namaController,
            onChanged: (val) {
              viewModel.dosen.nama = val;
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
            controller: nbmController,
            onChanged: (val) {
              viewModel.dosen.nbm = val;
            },
            prefixIcon: const Icon(
              UniconsLine.postcard,
              color: secondaryColor,
            ),
            hintText: 'NBM*',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'nbm'),
          ),
          const SizedBox(height: 16),
          CustomTextFieldOutline(
            controller: jabatanController,
            onChanged: (val) {
              viewModel.dosen.jabatan = val;
            },
            prefixIcon: const Icon(
              UniconsLine.calendar_alt,
              color: secondaryColor,
            ),
            hintText: 'Jabatan*',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'jabatan'),
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

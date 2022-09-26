import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';
import '../../../../../enums/form_dialog_type.dart';
import '../../../../../themes/app_text.dart';
import '../../../../../utils/validators.dart';
import '../../../../widgets/custom_dropdown_search.dart';
import '../../../../widgets/custom_textfield_outline.dart';
import './form_judul_dialog_view_model.dart';

class FormJudulDialogData {
  final FormDialogType type;
  final JudulModel? judul;

  FormJudulDialogData({
    required this.type,
    this.judul,
  });
}

class FormJudulDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const FormJudulDialogView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormJudulDialogViewModel>.nonReactive(
      viewModelBuilder: () => FormJudulDialogViewModel(),
      onModelReady: (FormJudulDialogViewModel model) async {
        await model.init(completer, request.data);
      },
      builder: (
        BuildContext context,
        FormJudulDialogViewModel model,
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

class _HookForm extends HookViewModelWidget<FormJudulDialogViewModel> {
  const _HookForm({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
      BuildContext context, FormJudulDialogViewModel viewModel) {
    final judulController =
        useTextEditingController(text: viewModel.judul.judul);
    final fileController = useTextEditingController();

    return Form(
      key: viewModel.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldOutline(
            controller: judulController,
            onChanged: (val) {
              viewModel.judul.judul = val;
            },
            prefixIcon: const Icon(
              UniconsLine.book,
              color: secondaryColor,
            ),
            hintText: 'Judul skripsi*',
            textInputAction: TextInputAction.next,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'judul skripsi'),
          ),
          const SizedBox(height: 16),
          CustomTextFieldOutline(
            controller: fileController,
            onChanged: (val) {
              viewModel.judul.judul = val;
            },
            prefixIcon: const Icon(
              UniconsLine.file_upload_alt,
              color: secondaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () => viewModel.openFilePicker(fileController),
              icon: const Icon(
                Icons.upload_file,
                color: greenColor,
              ),
            ),
            hintText: 'File pengajuan judul skripsi',
            readOnly: true,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          CustomDropdownSearch<MahasiswaModel>(
            prefixIcon: const Icon(
              UniconsLine.user,
              color: secondaryColor,
            ),
            hintText: 'Pilih mahasiswa (Boleh dikosongkan)',
            items: viewModel.mahasiswas,
            itemAsString: (item) => "${item.nama} (${item.nim})",
            selectedItem: viewModel.judul.mahasiswaId != null
                ? viewModel.mahasiswas.firstWhere(
                    (item) => item.id == viewModel.judul.mahasiswaId)
                : null,
            onChanged: (item) {
              viewModel.judul.mahasiswaId = item?.id;
            },
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
                    viewModel.type == FormDialogType.add ? 'Simpan' : 'Ubah',
                  ),
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

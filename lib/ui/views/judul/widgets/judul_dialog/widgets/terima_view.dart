import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pengajuan_judul_dashboard/models/dosen_model.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/judul_dialog_view_model.dart';
import 'package:pengajuan_judul_dashboard/utils/validators.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:unicons/unicons.dart';

import '../../../../../../enums/judul_dialog_type.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_text.dart';
import '../../../../../widgets/custom_dropdown_search.dart';

class TerimaView extends HookViewModelWidget<JudulDialogViewModel> {
  const TerimaView({super.key});

  @override
  Widget buildViewModelWidget(
      BuildContext context, JudulDialogViewModel viewModel) {
    final selectedPembimbing1 = useState<String?>(null);
    final selectedPembimbing2 = useState<String?>(null);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi',
          style: boldTextStyle.copyWith(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Judul skripsi ${viewModel.judul.judul} akan diterima?',
          style: mediumTextStyle.copyWith(
            fontSize: 18,
            color: fontTitleGreyColor,
          ),
        ),
        const SizedBox(height: 16),
        Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              CustomDropdownSearch<DosenModel>(
                prefixIcon: const Icon(
                  UniconsLine.user_md,
                  color: secondaryColor,
                ),
                hintText: 'Pilih pembimbing 1',
                items: viewModel.pembimbings
                    .where((x) => x.id != selectedPembimbing2.value)
                    .toList(),
                itemAsString: (item) => "${item.nama} (${item.nbm})",
                onChanged: (item) {
                  selectedPembimbing1.value = item?.id;
                  viewModel.notifyListeners();
                },
                validator: (val) => Validator.validateEmpty(
                    value: val?.nama,
                    errorMessage: 'Silahkan pilih pembimbing 1'),
              ),
              const SizedBox(height: 8),
              CustomDropdownSearch<DosenModel>(
                prefixIcon: const Icon(
                  UniconsLine.user_md,
                  color: secondaryColor,
                ),
                hintText: 'Pilih pembimbing 2',
                items: viewModel.pembimbings
                    .where((x) => x.id != selectedPembimbing1.value)
                    .toList(),
                itemAsString: (item) => "${item.nama} (${item.nbm})",
                onChanged: (item) {
                  selectedPembimbing2.value = item?.id;
                  viewModel.notifyListeners();
                },
                validator: (val) => Validator.validateEmpty(
                    value: val?.nama,
                    errorMessage: 'Silahkan pilih pembimbing 2'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Flexible(
              child: ElevatedButton.icon(
                onPressed: viewModel.isBusy
                    ? null
                    : () => viewModel
                        .changeJudulDialogType(JudulDialogType.hasilDeteksi),
                style: ElevatedButton.styleFrom(
                  backgroundColor: dangerColor,
                  disabledBackgroundColor: dangerColor.withOpacity(.3),
                  disabledForegroundColor: dangerColor.withOpacity(.8),
                ),
                icon: const Icon(
                  UniconsLine.arrow_circle_left,
                ),
                label: const Text('Batal'),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: ElevatedButton.icon(
                onPressed: viewModel.isBusy
                    ? null
                    : () => viewModel.onTerima(
                          pembimbing1ID: selectedPembimbing1.value,
                          pembimbing2ID: selectedPembimbing2.value,
                        ),
                icon: viewModel.isBusy
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Icon(UniconsLine.envelope_send),
                label: const Text('Terima'),
              ),
            ),
          ],
        )
      ],
    );
  }
}

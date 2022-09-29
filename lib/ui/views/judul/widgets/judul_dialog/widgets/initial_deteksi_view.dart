import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pengajuan_judul_dashboard/enums/judul_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/themes/app_text.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/judul_dialog_view_model.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_textfield_outline.dart';
import 'package:pengajuan_judul_dashboard/utils/validators.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:unicons/unicons.dart';

class InitialDeteksiView extends HookViewModelWidget<JudulDialogViewModel> {
  const InitialDeteksiView({super.key});

  @override
  Widget buildViewModelWidget(
      BuildContext context, JudulDialogViewModel viewModel) {
    final kController = useTextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total dataset: ${viewModel.totalDataSet} Judul',
          style: mediumTextStyle.copyWith(fontSize: 21),
        ),
        const SizedBox(height: 16),
        Form(
          key: viewModel.formKey,
          child: CustomTextFieldOutline(
            controller: kController,
            hintText: 'Masukkan nilai K',
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (val) => Validator.validateEmpty(
              value: val,
              field: 'Nilai K',
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Nilai K adalah jumlah tetangga terdekat pada algoritma K-Nearest Neighbor.',
            style: regularTextStyle.copyWith(
              color: fontDescriptionGreyColor,
              fontSize: 12,
            ),
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
                        .changeJudulDialogType(JudulDialogType.details),
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
                    : () => viewModel.onDeteksi(kController.text),
                icon: viewModel.isBusy
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Icon(UniconsLine.process),
                label: const Text('Mulai'),
              ),
            ),
          ],
        )
      ],
    );
  }
}

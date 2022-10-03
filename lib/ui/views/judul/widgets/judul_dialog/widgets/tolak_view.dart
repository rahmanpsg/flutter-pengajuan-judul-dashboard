import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/judul_dialog_view_model.dart';
import 'package:pengajuan_judul_dashboard/utils/validators.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:unicons/unicons.dart';

import '../../../../../../enums/judul_dialog_type.dart';
import '../../../../../../app/themes/app_colors.dart';
import '../../../../../../app/themes/app_text.dart';
import '../../../../../widgets/custom_textfield_outline.dart';

class TolakView extends HookViewModelWidget<JudulDialogViewModel> {
  const TolakView({super.key});

  @override
  Widget buildViewModelWidget(
      BuildContext context, JudulDialogViewModel viewModel) {
    final koreksiController = useTextEditingController();
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
          'Judul skripsi ${viewModel.judul.judul} akan ditolak?',
          style: mediumTextStyle.copyWith(
            fontSize: 18,
            color: fontTitleGreyColor,
          ),
        ),
        const SizedBox(height: 16),
        Form(
          key: viewModel.formKey,
          child: CustomTextFieldOutline(
            controller: koreksiController,
            hintText: 'Masukkan koreksi...',
            maxLines: 5,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'koreksi'),
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
                    : () => viewModel.onTolak(koreksi: koreksiController.text),
                icon: viewModel.isBusy
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Icon(UniconsLine.envelope_send),
                label: const Text('Tolak'),
              ),
            ),
          ],
        )
      ],
    );
  }
}

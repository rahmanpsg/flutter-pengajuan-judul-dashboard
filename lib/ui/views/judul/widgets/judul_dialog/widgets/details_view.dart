import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengajuan_judul_dashboard/enums/judul_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/enums/list_detail_type.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_text.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/judul_dialog_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import 'list_detail.dart';

class DetailsView extends ViewModelWidget<JudulDialogViewModel> {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context, JudulDialogViewModel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detail Judul',
              style: boldTextStyle.copyWith(
                fontSize: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                viewModel.completer(DialogResponse());
              },
              icon: const Icon(UniconsLine.times),
            )
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListDetail(
                title: 'Judul skripsi',
                subtitle: viewModel.judul.judul!,
              ),
              const SizedBox(height: 16),
              if (viewModel.judul.fileData != null) ...[
                ListTile(
                  onTap: viewModel.onDownloadDocument,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: mainGreyColor),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  leading: SvgPicture.asset(
                    'assets/svg/doc.svg',
                    width: 30,
                  ),
                  title: Text(
                    viewModel.judul.fileData!.name,
                  ),
                  subtitle: Text(viewModel.judul.fileData!.size),
                ),
                const SizedBox(height: 16)
              ],
              ListDetail(
                title: 'Status',
                subtitle: viewModel.judul.statusString,
                color: viewModel.judul.statusColor,
                type: ListDetailType.chip,
              ),
              const SizedBox(height: 16),
              if (viewModel.judul.koreksi != null) ...[
                ListDetail(
                  title: 'Koreksi',
                  subtitle: viewModel.judul.koreksi ?? '',
                ),
                const SizedBox(height: 16),
              ],
              if (viewModel.judul.mahasiswaId != null) ...[
                ListDetail(
                  title: 'Mahasiswa',
                  subtitle: viewModel.mahasiswa!.nama!,
                  description: viewModel.mahasiswa!.nim,
                  type: ListDetailType.circle,
                ),
                const SizedBox(height: 16)
              ],
              if (viewModel.pembimbing1 != null) ...[
                ListDetail(
                  title: 'Pembimbing 1',
                  subtitle: viewModel.pembimbing1?.nama ?? '',
                  description: viewModel.pembimbing1?.nbm ?? '',
                  type: ListDetailType.circle,
                ),
                const SizedBox(height: 16),
              ],
              if (viewModel.pembimbing2 != null) ...[
                ListDetail(
                  title: 'Pembimbing 2',
                  subtitle: viewModel.pembimbing2?.nama ?? '',
                  description: viewModel.pembimbing2?.nbm ?? '',
                  type: ListDetailType.circle,
                ),
                const SizedBox(height: 16),
              ],
              ListDetail(
                title: 'Tanggal upload',
                subtitle: viewModel.judul.tanggalUploadFormat,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        if (viewModel.judul.status == null)
          Row(
            children: [
              Flexible(
                child: ElevatedButton.icon(
                  onPressed: () => viewModel
                      .changeJudulDialogType(JudulDialogType.initialDeteksi),
                  icon: const Icon(UniconsLine.sync_icon),
                  label: const Text('Deteksi judul'),
                ),
              )
            ],
          )
      ],
    );
  }
}

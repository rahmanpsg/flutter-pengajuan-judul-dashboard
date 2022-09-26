import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_chip.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_circle_nickname.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_text.dart';
import './details_judul_dialog_view_model.dart';

class DetailsJudulDialogData {
  final JudulModel judul;

  const DetailsJudulDialogData({required this.judul});
}

class DetailsJudulDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DetailsJudulDialogView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsJudulDialogViewModel>.reactive(
      viewModelBuilder: () => DetailsJudulDialogViewModel(),
      onModelReady: (DetailsJudulDialogViewModel model) async {
        await model.init(completer, request.data);
      },
      builder: (
        BuildContext context,
        DetailsJudulDialogViewModel model,
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
                          completer(DialogResponse());
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
                        _ListDetail(
                          title: 'Judul skripsi',
                          subtitle: model.judul.judul!,
                        ),
                        const SizedBox(height: 16),
                        if (model.judul.fileData != null) ...[
                          ListTile(
                            onTap: model.onDownloadDocument,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: mainGreyColor),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            leading: SvgPicture.asset(
                              'assets/svg/doc.svg',
                              width: 30,
                            ),
                            title: Text(
                              model.judul.fileData!.name,
                            ),
                            subtitle: Text(model.judul.fileData!.size),
                          ),
                          const SizedBox(height: 16)
                        ],
                        _ListDetail(
                          title: 'Status',
                          subtitle: model.judul.statusString,
                          color: model.judul.statusColor,
                          type: ListDetailType.chip,
                        ),
                        const SizedBox(height: 16),
                        if (model.judul.mahasiswaId != null) ...[
                          _ListDetail(
                            title: 'Mahasiswa',
                            subtitle: model.mahasiswa!.nama!,
                            description: model.mahasiswa!.nim,
                            type: ListDetailType.circle,
                          ),
                          const SizedBox(height: 16)
                        ],
                        if (model.judul.pembimbingIds != null)
                          ...model.pembimbings
                              .map(
                                (item) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _ListDetail(
                                      title: item.nama!,
                                      subtitle: item.nbm!,
                                      type: ListDetailType.circle,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              )
                              .toList(),
                        _ListDetail(
                          title: 'Tanggal upload',
                          subtitle: model.judul.tanggalUploadFormat,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(UniconsLine.sync_icon),
                          label: const Text('Deteksi judul'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

enum ListDetailType { text, chip, circle }

class _ListDetail extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? description;
  final Color? color;
  final ListDetailType type;

  const _ListDetail({
    Key? key,
    required this.title,
    required this.subtitle,
    this.description,
    this.color = mainColor,
    this.type = ListDetailType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: regularTextStyle.copyWith(
            fontSize: 16,
            color: fontTitleGreyColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (type == ListDetailType.chip)
              CustomChip(text: subtitle, color: color!),
            if (type == ListDetailType.circle) ...[
              CustomCircleNickname(name: subtitle),
              const SizedBox(width: 8),
            ],
            if (type == ListDetailType.text || type == ListDetailType.circle)
              Column(
                children: [
                  Text(
                    subtitle,
                    style: regularTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  if (description != null)
                    Text(
                      description!,
                      style: regularTextStyle.copyWith(
                        color: fontDescriptionGreyColor,
                        fontSize: 16,
                      ),
                    ),
                ],
              )
          ],
        )
      ],
    );
  }
}

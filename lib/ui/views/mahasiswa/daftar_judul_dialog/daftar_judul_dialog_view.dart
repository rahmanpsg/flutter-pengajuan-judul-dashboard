import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';
import '../../../../enums/list_detail_type.dart';
import '../../../widgets/custom_circle_nickname.dart';
import '../../judul/widgets/judul_dialog/widgets/list_detail.dart';
import './daftar_judul_dialog_view_model.dart';

class DaftarJudulDialogData {
  final MahasiswaModel mahasiswa;

  const DaftarJudulDialogData({required this.mahasiswa});
}

class DaftarJudulDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DaftarJudulDialogView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DaftarJudulDialogViewModel>.reactive(
      viewModelBuilder: () => DaftarJudulDialogViewModel(),
      onModelReady: (DaftarJudulDialogViewModel model) async {
        await model.init(request.data);
      },
      builder: (
        BuildContext context,
        DaftarJudulDialogViewModel model,
        Widget? child,
      ) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daftar Pengajuan Judul',
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
                  const SizedBox(height: 16),
                  ListDetail(
                    title: 'Mahasiswa',
                    subtitle: model.mahasiswa.nama!,
                    description: model.mahasiswa.nim,
                    type: ListDetailType.circle,
                  ),
                  const SizedBox(height: 16),
                  if (model.juduls.isEmpty)
                    const Text('Belum ada judul yang diajukan')
                  else
                    CarouselSlider.builder(
                      itemCount: model.juduls.length,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        aspectRatio: 1.4,
                      ),
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        final judul = model.juduls[itemIndex];

                        return Card(
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomCircleNickname(
                                  name: "${itemIndex + 1}",
                                  color: mainColor,
                                ),
                                const SizedBox(width: 16),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      ListDetail(
                                        title: 'Judul skripsi',
                                        subtitle: judul.judul.toString(),
                                      ),
                                      const SizedBox(height: 16),
                                      if (judul.fileData != null) ...[
                                        ListTile(
                                          onTap: () => model.onDownloadDocument(
                                            judul.fileData!.url!,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                          leading: SvgPicture.asset(
                                            'assets/svg/doc.svg',
                                            width: 30,
                                          ),
                                          title: Text(
                                            judul.fileData!.name,
                                          ),
                                          subtitle: Text(judul.fileData!.size),
                                        ),
                                        const SizedBox(height: 16)
                                      ],
                                      ListDetail(
                                        title: 'Status',
                                        subtitle: judul.statusString,
                                        color: judul.statusColor,
                                        type: ListDetailType.chip,
                                      ),
                                      const SizedBox(height: 16),
                                      ListDetail(
                                        title: 'Tanggal upload',
                                        subtitle: judul.tanggalUploadFormat,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

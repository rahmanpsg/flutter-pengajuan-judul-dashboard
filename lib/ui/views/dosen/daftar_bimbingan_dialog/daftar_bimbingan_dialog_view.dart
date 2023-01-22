import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengajuan_judul_dashboard/models/dosen_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';
import '../../../../enums/list_detail_type.dart';
import '../../../widgets/custom_circle_nickname.dart';
import '../../judul/widgets/judul_dialog/widgets/list_detail.dart';
import './daftar_bimbingan_dialog_view_model.dart';

class DaftarBimbinganDialogData {
  final DosenModel dosen;

  const DaftarBimbinganDialogData({required this.dosen});
}

class DaftarBimbinganDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DaftarBimbinganDialogView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DaftarBimbinganDialogViewModel>.reactive(
      viewModelBuilder: () => DaftarBimbinganDialogViewModel(),
      onModelReady: (DaftarBimbinganDialogViewModel model) async {
        await model.init(request.data);
      },
      builder: (
        BuildContext context,
        DaftarBimbinganDialogViewModel model,
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
                        'Daftar Bimbingan Dosen',
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
                    title: 'Dosen',
                    subtitle: model.dosen.nama!,
                    description: model.dosen.nbm,
                    type: ListDetailType.circle,
                  ),
                  const SizedBox(height: 16),
                  if (model.isBusy)
                    const CircularProgressIndicator()
                  else if (model.list.isEmpty)
                    const Text('Tidak ada data')
                  else
                    CarouselSlider.builder(
                      itemCount: model.list.length,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        aspectRatio: 1.15,
                      ),
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        final bimbingan = model.list[itemIndex];

                        return Card(
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          child: SingleChildScrollView(
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
                                        title: 'Mahasiswa',
                                        subtitle: bimbingan.mahasiswa.nama!,
                                        description: bimbingan.mahasiswa.nim,
                                        type: ListDetailType.circle,
                                      ),
                                      const SizedBox(height: 16),
                                      ListDetail(
                                        title: 'Judul skripsi',
                                        subtitle:
                                            bimbingan.judul.judul.toString(),
                                      ),
                                      const SizedBox(height: 16),
                                      if (bimbingan.judul.fileData != null) ...[
                                        ListTile(
                                          onTap: () => model.onDownloadDocument(
                                            bimbingan.judul.fileData!.url!,
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
                                            bimbingan.judul.fileData!.name,
                                          ),
                                          subtitle: Text(
                                              bimbingan.judul.fileData!.size),
                                        ),
                                        const SizedBox(height: 16)
                                      ],
                                      const SizedBox(height: 16),
                                      ListDetail(
                                        title: 'Pembimbing',
                                        subtitle:
                                            bimbingan.pembimbing.toString(),
                                      ),
                                      const SizedBox(height: 16),
                                      ListDetail(
                                        title: 'Tanggal upload',
                                        subtitle:
                                            bimbingan.judul.tanggalUploadFormat,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

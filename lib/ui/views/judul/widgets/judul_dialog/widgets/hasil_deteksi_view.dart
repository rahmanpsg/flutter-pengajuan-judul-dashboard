import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/enums/judul_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/enums/list_detail_type.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_text.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_dialog/judul_dialog_view_model.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_circle_nickname.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import 'list_detail.dart';

class HasilDeteksiView extends ViewModelWidget<JudulDialogViewModel> {
  const HasilDeteksiView({super.key});

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
              'Hasil Deteksi Judul',
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
          child: ListDetail(
            title: 'Judul skripsi',
            subtitle: viewModel.judul.judul!,
          ),
        ),
        const SizedBox(height: 16),
        CarouselSlider.builder(
            itemCount: viewModel.hasilDeteksiList.length,
            options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              final hasilDeteksi = viewModel.hasilDeteksiList[itemIndex];

              return Container(
                // width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: backgroundColor,
                ),
                padding: const EdgeInsets.all(16),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Flexible(
                            child: Text(
                              hasilDeteksi.judul ?? '',
                              style: mediumTextStyle.copyWith(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListDetail(
                            title: 'Jarak',
                            subtitle: hasilDeteksi.jarak.toString(),
                          ),
                          const SizedBox(height: 16),
                          ListDetail(
                            title: 'Similarity',
                            subtitle:
                                '${hasilDeteksi.persentase.toStringAsFixed(2)}%',
                            color: hasilDeteksi.persentaseColor,
                            type: ListDetailType.chip,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        const SizedBox(height: 16),
        Row(
          children: [
            Flexible(
              child: ElevatedButton.icon(
                onPressed: () =>
                    viewModel.changeJudulDialogType(JudulDialogType.tolak),
                icon: const Icon(UniconsLine.times_circle),
                label: const Text('Tolak Judul'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: dangerColor,
                  disabledBackgroundColor: dangerColor.withOpacity(.3),
                  disabledForegroundColor: dangerColor.withOpacity(.8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: ElevatedButton.icon(
                onPressed: () =>
                    viewModel.changeJudulDialogType(JudulDialogType.terima),
                icon: const Icon(UniconsLine.check_circle),
                label: const Text('Terima Judul'),
              ),
            )
          ],
        )
      ],
    );
  }
}

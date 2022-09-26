import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text.dart';
import '../../../widgets/custom_chip.dart';
import '../judul_view_model.dart';

class JudulTabBar extends ViewModelWidget<JudulViewModel> {
  const JudulTabBar({super.key});

  @override
  Widget build(BuildContext context, JudulViewModel viewModel) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    return TabBar(
      onTap: viewModel.setTabIndexSelected,
      tabs: [
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(child: Text('Semua')),
              if (deviceType != DeviceScreenType.mobile) ...[
                const SizedBox(width: 8),
                CustomChip(
                  text: viewModel.total.toString(),
                  color: viewModel.tabIndexSelected == 0
                      ? mainColor
                      : fontParagraphColor,
                ),
              ],
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Belum diverifikasi',
                  style: mediumTextStyle.copyWith(
                      color: viewModel.tabIndexSelected == 1
                          ? yellowColor
                          : fontParagraphColor),
                ),
              ),
              if (deviceType != DeviceScreenType.mobile) ...[
                const SizedBox(width: 8),
                CustomChip(
                  text: viewModel.totalBelumDiverifikasi.toString(),
                  color: viewModel.tabIndexSelected == 1
                      ? yellowColor
                      : fontParagraphColor,
                )
              ],
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Diterima',
                  style: mediumTextStyle.copyWith(
                      color: viewModel.tabIndexSelected == 2
                          ? greenColor
                          : fontParagraphColor),
                ),
              ),
              if (deviceType != DeviceScreenType.mobile) ...[
                const SizedBox(width: 8),
                CustomChip(
                  text: viewModel.totalDiterima.toString(),
                  color: viewModel.tabIndexSelected == 2
                      ? greenColor
                      : fontParagraphColor,
                ),
              ],
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Ditolak',
                  style: mediumTextStyle.copyWith(
                      color: viewModel.tabIndexSelected == 3
                          ? dangerColor
                          : fontParagraphColor),
                ),
              ),
              if (deviceType != DeviceScreenType.mobile) ...[
                const SizedBox(width: 8),
                CustomChip(
                  text: viewModel.totalDitolak.toString(),
                  color: viewModel.tabIndexSelected == 3
                      ? dangerColor
                      : fontParagraphColor,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

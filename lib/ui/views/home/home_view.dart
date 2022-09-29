import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/themes/app_text.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../widgets/custom_stats.dart';
import './home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(getValueForScreenType<double>(
              context: context,
              mobile: 16,
              tablet: 32,
              desktop: 32,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HOME",
                  style: boldTextStyle.copyWith(
                    fontSize: 24,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 16),
                SelectableText(
                  "Selamat Datang di Aplikasi Pengajuan Judul Skripsi Prodi Informatika Fakultas Teknik Universitas Muhammadiyah Parepare",
                  style: mediumTextStyle.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 32),
                const Divider(
                  color: fontSecondaryColor,
                ),
                const SizedBox(height: 32),
                Center(
                  child: Wrap(
                    runSpacing: 32,
                    spacing: 32,
                    children: [
                      CustomStats(
                        text: "Total Mahasiswa",
                        total: model.totalMahasiswa,
                        iconData: UniconsSolid.user_arrows,
                        color: secondaryColor,
                      ),
                      CustomStats(
                        text: "Total Judul",
                        total: model.totalJudul,
                        iconData: UniconsSolid.apps,
                        color: mainColor,
                      ),
                      CustomStats(
                        text: "Total Judul Diterima",
                        total: model.totalDiterima,
                        iconData: UniconsSolid.check_circle,
                        color: greenColor,
                      ),
                      CustomStats(
                        text: "Total Judul Ditolak",
                        total: model.totalDitolak,
                        iconData: UniconsSolid.times_circle,
                        color: dangerColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

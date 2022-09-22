import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../themes/app_text.dart';

import './mahasiswa_view_model.dart';
import 'widgets/mahasiswa_table.dart';

class MahasiswaView extends StatelessWidget {
  const MahasiswaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MahasiswaViewModel>.nonReactive(
      viewModelBuilder: () => MahasiswaViewModel(),
      onModelReady: (MahasiswaViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        MahasiswaViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Padding(
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
                  "DAFTAR MAHASISWA",
                  style: boldTextStyle.copyWith(
                    fontSize: 24,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: OutlinedButton.icon(
                    onPressed: () => model.onAddOrEdit(null),
                    icon: const Icon(UniconsLine.plus),
                    label: const Text("Tambah data"),
                  ),
                ),
                const SizedBox(height: 8),
                const Flexible(
                  child: MahasiswaTable(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

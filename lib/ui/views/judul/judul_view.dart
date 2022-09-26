import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_tab_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../themes/app_text.dart';
import './judul_view_model.dart';
import 'widgets/judul_table.dart';

class JudulView extends StatelessWidget {
  const JudulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JudulViewModel>.nonReactive(
      viewModelBuilder: () => JudulViewModel(),
      onModelReady: (JudulViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        JudulViewModel model,
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
            child: DefaultTabController(
              length: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DAFTAR JUDUL",
                    style: boldTextStyle.copyWith(
                      fontSize: 24,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const JudulTabBar(),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: OutlinedButton.icon(
                      onPressed: () => model.onAddOrEdit(null),
                      icon: const Icon(UniconsLine.plus),
                      label: const Text("Tambah judul"),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Flexible(
                    child: JudulTable(),
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

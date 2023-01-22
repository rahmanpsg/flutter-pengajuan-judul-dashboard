import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_tab_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../app/themes/app_text.dart';
import '../../widgets/custom_search_text_field.dart';
import './judul_view_model.dart';
import 'widgets/judul_table.dart';

class JudulView extends StatelessWidget {
  const JudulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: width * 0.11,
                        child: OutlinedButton.icon(
                          onPressed: () => model.onAddOrEdit(null),
                          icon: const Icon(UniconsLine.plus),
                          label: const Text("Tambah judul"),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.3,
                        child: CustomSearchTextField(
                          hintText: 'Cari',
                          onSearch: model.onSearch,
                        ),
                      ),
                    ],
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

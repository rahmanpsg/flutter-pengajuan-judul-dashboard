import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/judul_tab_bar.dart';
import 'package:pengajuan_judul_dashboard/ui/views/table/table_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../themes/app_text.dart';
import '../table/models/column_item.dart';
import './judul_view_model.dart';

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
                  Flexible(
                    child: TableView(
                      headerColor: secondaryColor,
                      columns: [
                        ColumnItem(value: "#", width: 50),
                        ColumnItem(value: "Judul", width: 520),
                        ColumnItem(value: "Tanggal", width: 200),
                        ColumnItem(value: "Status", width: 265),
                        ColumnItem(value: "Aksi", width: 100),
                      ],
                      rows: model.list
                          .asMap()
                          .entries
                          .map(
                            (entry) => TableRow(
                              children: [
                                Text("${entry.key + 1}"),
                                Text("${entry.value.judul}"),
                                Text("${entry.value.tanggal}"),
                                Text("${entry.value.status}"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Tooltip(
                                      message: "Lihat",
                                      preferBelow: false,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          // onTap: () => viewModel.onAddOrEdit(entry.value),
                                          child: const Icon(
                                            UniconsLine.eye,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tooltip(
                                      message: "Edit",
                                      preferBelow: false,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () =>
                                              model.onAddOrEdit(entry.value),
                                          child: const Icon(
                                            UniconsLine.edit,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(width: 4),
                                    Tooltip(
                                      message: 'Delete',
                                      preferBelow: false,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          // onTap: () => model.onDelete(entry.value),
                                          child: const Icon(
                                            UniconsLine.trash,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
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

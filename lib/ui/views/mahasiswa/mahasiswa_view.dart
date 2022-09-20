import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/ui/views/table/table_view.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_textfield_outline.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../themes/app_text.dart';
import '../table/models/column_item.dart';
import './mahasiswa_view_model.dart';

class MahasiswaView extends StatelessWidget {
  const MahasiswaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MahasiswaViewModel>.reactive(
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
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: OutlinedButton.icon(
                        onPressed: () => model.onAddOrEdit(null),
                        icon: const Icon(UniconsLine.plus),
                        label: const Text("Tambah data"),
                      ),
                    ),
                    // const SizedBox(width: 16),
                    // ConstrainedBox(
                    //   constraints: const BoxConstraints(maxWidth: 300),
                    //   child: const CustomTextFieldOutline(
                    //     hintText: 'Cari',
                    //     outlineColor: secondaryColor,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: LayoutBuilder(builder: (context, constrain) {
                    print(constrain.maxWidth);
                    final w = constrain.maxWidth;
                    return TableView(
                      headerColor: secondaryColor,
                      columns: [
                        ColumnItem(value: "#", width: 30),
                        ColumnItem(value: "Nama", width: 300),
                        ColumnItem(value: "Nim", width: 200),
                        ColumnItem(value: "Angkatan", width: 200),
                        ColumnItem(value: "Status", width: 280),
                        ColumnItem(value: "Aksi", width: 110),
                      ],
                      rows: model.list
                          .asMap()
                          .entries
                          .map(
                            (entry) => TableRow(
                              children: [
                                Text("${entry.key + 1}"),
                                Text("${entry.value.nama}"),
                                Text("${entry.value.nim}"),
                                Text("${entry.value.angkatan}"),
                                Text("${entry.value.nama}"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
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
                                    Tooltip(
                                      message: 'Delete',
                                      preferBelow: false,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () =>
                                              model.onDelete(entry.value),
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
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

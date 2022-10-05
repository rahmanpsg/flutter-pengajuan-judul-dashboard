import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/ui/views/mahasiswa/mahasiswa_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../../app/themes/app_colors.dart';
import '../../table/models/column_item.dart';
import '../../table/table_view.dart';

class MahasiswaTable extends ViewModelWidget<MahasiswaViewModel> {
  const MahasiswaTable({super.key});

  @override
  Widget build(BuildContext context, MahasiswaViewModel viewModel) {
    return TableView(
      headerColor: secondaryColor,
      columns: [
        ColumnItem(value: "#", width: 50),
        ColumnItem(value: "Nama", width: 500),
        ColumnItem(value: "Nim", width: 250),
        ColumnItem(value: "Angkatan", width: 200),
        // ColumnItem(value: "Status", width: 265),
        ColumnItem(value: "Aksi", width: 130),
      ],
      rows: viewModel.list
          .asMap()
          .entries
          .map(
            (entry) => TableRow(
              children: [
                Text("${entry.key + 1}"),
                SelectableText("${entry.value.nama}"),
                SelectableText("${entry.value.nim}"),
                SelectableText("${entry.value.angkatan}"),
                // const CustomChip(
                //   text: 'Accepted',
                //   color: greenColor,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Tooltip(
                      message: "Edit",
                      preferBelow: false,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => viewModel.onAddOrEdit(entry.value),
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
                          onTap: () => viewModel.onDelete(entry.value),
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
  }
}

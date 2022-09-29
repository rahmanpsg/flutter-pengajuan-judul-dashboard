import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/ui/views/dosen/dosen_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../../themes/app_colors.dart';
import '../../table/models/column_item.dart';
import '../../table/table_view.dart';

class DosenTable extends ViewModelWidget<DosenViewModel> {
  const DosenTable({super.key});

  @override
  Widget build(BuildContext context, DosenViewModel viewModel) {
    return TableView(
      headerColor: secondaryColor,
      columns: [
        ColumnItem(value: "#", width: 50),
        ColumnItem(value: "Nama", width: 310),
        ColumnItem(value: "Nbm", width: 200),
        ColumnItem(value: "Jabatan", width: 430),
        ColumnItem(value: "Aksi", width: 140),
      ],
      rows: viewModel.list
          .asMap()
          .entries
          .map(
            (entry) => TableRow(
              children: [
                Text("${entry.key + 1}"),
                SelectableText("${entry.value.nama}"),
                SelectableText("${entry.value.nbm}"),
                SelectableText("${entry.value.jabatan}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          onTap: () => viewModel.onAddOrEdit(entry.value),
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

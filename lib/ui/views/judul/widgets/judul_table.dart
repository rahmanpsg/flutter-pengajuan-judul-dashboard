import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/judul_view_model.dart';
import 'package:pengajuan_judul_dashboard/ui/views/table/table_view.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../widgets/custom_chip.dart';
import '../../table/models/column_item.dart';

class JudulTable extends ViewModelWidget<JudulViewModel> {
  const JudulTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, JudulViewModel viewModel) {
    return TableView(
      headerColor: secondaryColor,
      columns: [
        ColumnItem(value: "#", width: 50),
        ColumnItem(value: "Judul", width: 520),
        ColumnItem(value: "Tanggal", width: 200),
        ColumnItem(value: "Status", width: 265),
        ColumnItem(value: "Aksi", width: 100),
      ],
      rows: viewModel.listFilter
          .asMap()
          .entries
          .map(
            (entry) => TableRow(
              children: [
                Text("${entry.key + 1}"),
                SelectableText("${entry.value.judul}"),
                SelectableText(entry.value.tanggalFormat),
                CustomChip(
                  text: entry.value.statusString,
                  color: entry.value.statusColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Tooltip(
                      message: "Lihat",
                      preferBelow: false,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => viewModel.openDetails(entry.value),
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

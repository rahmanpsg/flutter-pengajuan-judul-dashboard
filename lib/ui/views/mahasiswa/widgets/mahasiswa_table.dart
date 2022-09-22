import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:pengajuan_judul_dashboard/ui/views/mahasiswa/mahasiswa_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../../../themes/app_colors.dart';
import '../../../widgets/custom_chip.dart';
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
        ColumnItem(value: "Nama", width: 300),
        ColumnItem(value: "Nim", width: 200),
        ColumnItem(value: "Angkatan", width: 200),
        ColumnItem(value: "Status", width: 265),
        ColumnItem(value: "Aksi", width: 100),
      ],
      rows: viewModel.list
          .asMap()
          .entries
          .map(
            (entry) => TableRow(
              children: [
                Text("${entry.key + 1}"),
                Text("${entry.value.nama}"),
                Text("${entry.value.nim}"),
                Text("${entry.value.angkatan}"),
                const CustomChip(
                  text: 'Accepted',
                  color: greenColor,
                ),
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

  @override
  List<MahasiswaModel> selector(MahasiswaViewModel model) => model.list;
}

import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';
import 'package:stacked/stacked.dart';

import '../models/column_item.dart';
import '../table_viewmodel.dart';

class Body extends ViewModelWidget<TableViewModel> {
  final List<ColumnItem> columns;
  final List<Widget> children;

  const Body({
    Key? key,
    required this.columns,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, TableViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children
          .asMap()
          .entries
          .map(
            (entry) => Container(
              // color: Colors.grey.withOpacity(.5),
              width: columns.elementAt(entry.key).width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: entry.value,
            ),
          )
          .toList(),
    );
  }
}

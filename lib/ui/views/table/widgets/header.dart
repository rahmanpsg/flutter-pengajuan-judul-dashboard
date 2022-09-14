import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../models/column_item.dart';
import '../table_viewmodel.dart';

class Header extends ViewModelWidget<TableViewModel> {
  final List<ColumnItem> columns;
  final Color? color;

  const Header({
    Key? key,
    required this.columns,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, TableViewModel model) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns.map((column) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 30,
              width: column.width,
              child: Center(
                child: Text(
                  column.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../table_viewmodel.dart';

class Body extends ViewModelWidget<TableViewModel> {
  // final List<ColumnItem> columns;
  final List<Widget> children;

  const Body({
    Key? key,
    // required this.columns,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, TableViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

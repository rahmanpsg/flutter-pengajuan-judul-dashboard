import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';

import 'package:stacked/stacked.dart';

import 'models/column_item.dart';
import 'table_viewmodel.dart';
import 'widgets/header.dart';
// import 'widgets/toolbar.dart';
import 'widgets/body.dart';

class TableView extends StatelessWidget {
  final List<ColumnItem> columns;
  final List<TableRow>? rows;
  final BorderRadiusGeometry? borderRadius;
  final Color borderColor;
  final Color? headerColor;

  const TableView({
    Key? key,
    required this.columns,
    this.rows,
    this.borderRadius,
    this.borderColor = secondaryColor,
    this.headerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth =
        columns.map((column) => column.width).reduce((a, b) => a + b);

    print("maxWidth: $maxWidth");

    return ViewModelBuilder<TableViewModel>.reactive(
        viewModelBuilder: () => TableViewModel(),
        onModelReady: (model) => model.init(),
        builder: (
          BuildContext context,
          TableViewModel model,
          Widget? child,
        ) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: borderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SingleChildScrollView(
                        controller: model.headerScrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Header(
                          color: headerColor,
                          columns: columns,
                        ),
                      ),
                      // Divider(color: borderColor, thickness: 1),
                      if (rows != null && rows!.isNotEmpty)
                        Flexible(
                          child: SingleChildScrollView(
                            controller: model.bodyScrollController,
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: maxWidth + 130,
                              child: Scrollbar(
                                thickness: 10,
                                child: ListView.separated(
                                  // shrinkWrap: true,
                                  itemCount: rows!.length,
                                  // itemCount: rows!.length,
                                  itemBuilder: (_, index) => Body(
                                    children: (rows![index].children ??
                                        [Container()]),
                                  ),
                                  separatorBuilder: (_, index) => const Divider(
                                    color: mainColor,
                                    thickness: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (rows == null || rows!.isEmpty)
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Tidak ada data',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

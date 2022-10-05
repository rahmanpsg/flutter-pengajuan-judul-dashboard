import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_colors.dart';
import 'models/column_item.dart';
import 'widgets/header.dart';
// import 'widgets/toolbar.dart';
import 'widgets/body.dart';

class TableView extends HookWidget {
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
    final headerScrollController = useScrollController();
    final bodyScrollController = useScrollController();

    useEffect(() {
      bodyScrollController.addListener(() {
        headerScrollController.animateTo(
          bodyScrollController.offset,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeIn,
        );
      });
      return;
    });

    double maxWidth =
        columns.map((column) => column.width).reduce((a, b) => a + b);

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
                  controller: headerScrollController,
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
                      controller: bodyScrollController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        width: maxWidth + 130,
                        child: ListView.separated(
                          // shrinkWrap: true,
                          itemCount: rows!.length,
                          itemBuilder: (_, index) => Body(
                            columns: columns,
                            children: (rows![index].children ?? [Container()]),
                          ),
                          separatorBuilder: (_, index) => const Divider(
                            color: mainColor,
                            thickness: .1,
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
  }
}

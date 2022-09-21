import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/themes/app_colors.dart';
import 'models/column_item.dart';
import 'widgets/header.dart';
// import 'widgets/toolbar.dart';
import 'widgets/body.dart';

class TableView extends StatefulWidget {
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
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  final headerScrollController = ScrollController();
  final bodyScrollController = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    bodyScrollController.addListener(() {
      headerScrollController.animateTo(
        bodyScrollController.offset,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    headerScrollController.dispose();
    bodyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth =
        widget.columns.map((column) => column.width).reduce((a, b) => a + b);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: widget.borderColor,
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
                    color: widget.headerColor,
                    columns: widget.columns,
                  ),
                ),
                // Divider(color: borderColor, thickness: 1),
                if (widget.rows != null && widget.rows!.isNotEmpty)
                  Flexible(
                    child: SingleChildScrollView(
                      controller: bodyScrollController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        width: maxWidth + 130,
                        child: Scrollbar(
                          thickness: 10,
                          child: ListView.separated(
                            // shrinkWrap: true,
                            itemCount: widget.rows!.length,
                            // itemCount: rows!.length,
                            itemBuilder: (_, index) => Body(
                              columns: widget.columns,
                              children: (widget.rows![index].children ??
                                  [Container()]),
                            ),
                            separatorBuilder: (_, index) => const Divider(
                              color: mainColor,
                              thickness: .1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (widget.rows == null || widget.rows!.isEmpty)
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

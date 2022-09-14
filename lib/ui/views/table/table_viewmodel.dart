import 'package:flutter/material.dart';

import '../../../app/app.logger.dart';
import '../../../app/core/custom_base_view_model.dart';
import '../../../utils/debounce.dart';

class TableViewModel extends CustomBaseViewModel {
  final log = getLogger('TableViewModel');

  final headerScrollController = ScrollController();
  final bodyScrollController = ScrollController();
  final searchController = TextEditingController();

  final _debounce = Debounce(const Duration(milliseconds: 1000));

  // JurnalModel? _jurnal;

  // FileDataModel? _file;
  // FileDataModel? get file => _file;

  void init() async {
    bodyScrollController.addListener(() {
      headerScrollController.animateTo(
        bodyScrollController.offset,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });

    searchController.addListener(() {
      _debounce.call(() {
        setSearchTextFilter(searchController.text);
      });
    });
  }

  void setSearchTextFilter(String text) {
    if (text.isEmpty) return;

    setBusy(true);

    // _listFiltered = _list
    //     .where(
    //         (value) => value.label.toLowerCase().contains(text.toLowerCase()))
    //     .toList();

    setBusy(false);
  }

  @override
  void dispose() {
    headerScrollController.dispose();
    bodyScrollController.dispose();
    super.dispose();
  }
}

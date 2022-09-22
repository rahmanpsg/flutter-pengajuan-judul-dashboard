import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';

class JudulViewModel extends CustomBaseViewModel {
  final log = getLogger("JudulViewModel");

  int tabIndexSelected = 0;

  Future<void> init() async {}

  void setTabIndexSelected(int idx) {
    tabIndexSelected = idx;
    notifyListeners();
  }
}

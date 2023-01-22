import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'judul_dialog_view_model.dart';

class JudulDialogData {
  final JudulModel judul;

  const JudulDialogData({required this.judul});
}

class JudulDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const JudulDialogView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JudulDialogViewModel>.reactive(
      viewModelBuilder: () => JudulDialogViewModel(),
      onModelReady: (JudulDialogViewModel model) async {
        await model.init(completer, request.data);
      },
      builder: (
        BuildContext context,
        JudulDialogViewModel model,
        Widget? child,
      ) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 100),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: model.view,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import './year_picker_dialog_view_model.dart';

class YearPickerDialogData {
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;

  YearPickerDialogData({
    required this.selectedDate,
    DateTime? firstDate,
    DateTime? lastDate,
  })  : firstDate = firstDate ?? DateTime(2008),
        lastDate = lastDate ?? DateTime.now();
}

class YearPickerDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const YearPickerDialogView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<YearPickerDialogViewModel>.reactive(
      viewModelBuilder: () => YearPickerDialogViewModel(),
      onModelReady: (YearPickerDialogViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        YearPickerDialogViewModel model,
        Widget? child,
      ) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(request.title ?? ''),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: YearPicker(
                    firstDate: request.data!.firstDate,
                    lastDate: request.data!.lastDate,
                    selectedDate: request.data!.selectedDate,
                    onChanged: (dateTime) {
                      completer(DialogResponse(
                        confirmed: true,
                        data: dateTime,
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

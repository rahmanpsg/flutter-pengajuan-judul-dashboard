import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './judul_view_model.dart';

class JudulView extends StatelessWidget {
  const JudulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JudulViewModel>.reactive(
      viewModelBuilder: () => JudulViewModel(),
      onModelReady: (JudulViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        JudulViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'JudulView',
            ),
          ),
        );
      },
    );
  }
}

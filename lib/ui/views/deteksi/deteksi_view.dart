import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './deteksi_view_model.dart';

class DeteksiView extends StatelessWidget {
  const DeteksiView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeteksiViewModel>.reactive(
      viewModelBuilder: () => DeteksiViewModel(),
      onModelReady: (DeteksiViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        DeteksiViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'DeteksiView',
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/app.router.dart';
import 'package:pengajuan_judul_dashboard/models/api_response_model.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/core/custom_base_view_model.dart';
import '../../../main.dart';
import '../../../services/auth_service.dart';

class SignInViewModel extends CustomBaseViewModel {
  final log = getLogger("SignInViewModel");

  final _authService = locator<AuthService>();

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmit() async {
    if (formKey.currentState?.validate() != true) return;

    setBusy(true);

    final response = await _authService.login(
        email: "${usernameController.text}@user.com",
        password: passwordController.text);

    setBusy(false);

    log.d("response: $response");

    if (response is ApiResponseModelSuccess) {
      await syncAllData();

      navigationService.clearStackAndShow(Routes.dashboardView);

      return;
    }

    dialogService.showDialog(
      title: 'Error',
      description: response.message,
      dialogPlatform: DialogPlatform.Material,
    );
  }
}

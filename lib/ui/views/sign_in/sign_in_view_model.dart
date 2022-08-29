import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';

class SignInViewModel extends CustomBaseViewModel {
  final log = getLogger("SignInViewModel");

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmit() async {}
}

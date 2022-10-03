import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_text.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_textfield_outline.dart';
import 'package:pengajuan_judul_dashboard/utils/validators.dart';
import 'package:stacked/stacked.dart';

import './sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (
        BuildContext context,
        SignInViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .9,
                  maxWidth: 500,
                ),
                child: Form(
                  key: model.formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            'Sistem Pengajuan Judul Fakultas Teknik - UM Parepare',
                            style: boldTextStyle.copyWith(fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        CustomTextFieldOutline(
                          controller: model.usernameController,
                          hintText: "Username",
                          validator: (val) => Validator.validateEmpty(
                              value: val,
                              errorMessage: "Username tidak boleh kosong"),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFieldOutline(
                          controller: model.passwordController,
                          hintText: "Password",
                          obscureText: true,
                          validator: (val) => Validator.validateEmpty(
                              value: val,
                              errorMessage: "Password tidak boleh kosong"),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: model.isBusy ? null : model.onSubmit,
                          child: model.isBusy
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text("Masuk"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

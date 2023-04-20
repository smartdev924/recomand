import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email;
  bool firstSubmit = false;
  bool isSending = false;
  late AppService _appService;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appService = Provider.of<AppService>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (newEmail) => this.email = newEmail!,
            onChanged: (email) {
              if (firstSubmit) _formKey.currentState!.validate();
            },
            validator: (email) {
              if (email!.isEmpty) {
                return Languages.of(context)!.kEmailNullError;
              } else if (email.isNotEmpty &&
                  !emailValidatorRegExp.hasMatch(email)) {
                return Languages.of(context)!.kInvalidEmailError;
              }

              return null;
            },
            decoration: InputDecoration(
              labelText: Languages.of(context)!.email,
              hintText: Languages.of(context)!.pleaseendteryouremail,
              suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Mail.svg"),
            ),
            keyboardType: TextInputType.emailAddress,
          ),

          SizedBox(height: SizeConfig.screenHeight! * 0.05),
          isSending
              ? CircularProgressIndicator()
              : DefaultButton(
                  text: Languages.of(context)!.lab_send,
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isSending = true;
                      });
                      final response =
                          await _appService.forgotPassword(email: email);
                      if (response is String || response == null) {
                        setState(() {
                          isSending = false;
                        });
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: response,
                          ),
                        );
                      } else {
                        setState(() {
                          isSending = false;
                        });
                        GoRouter.of(context)
                            .pushNamed(APP_PAGE.resetPasword.toName);
                      }
                    }
                    firstSubmit = true;
                  },
                ),
          SizedBox(height: SizeConfig.screenHeight! * 0.1),
          // NoAccountText(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:localservice/constants.dart';

// import './sign_in_form.dart';
// import '../../../size_config.dart';
// import '../../../components/social_card.dart';
// import '../../../components/no_account_text.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';

class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: TextButton(
        onPressed: () =>
                GoRouter.of(context).pushNamed(APP_PAGE.forgotPassword.toName),
        child: Text(
          Languages.of(context)!.forgotpassword,
        ),
      ),
    );
  }
}

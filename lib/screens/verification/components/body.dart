import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Body extends StatefulWidget {
  const Body(
      // key? key,
      );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _onEditing = true;
  String _code = '';
  late AppService appService;

  @override
  void initState() {
    appService = Provider.of<AppService>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    //...
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 60),
          width: double.infinity,
          child: Text(
            'Verification code',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          child: Text(
            'We just send you a verify code. Check your inbox to get them.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 24),
        VerificationCode(
          textStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).primaryColor),
          keyboardType: TextInputType.number,
          underlineColor: Color.fromRGBO(154, 159, 165, 1),
          underlineUnfocusedColor: Color.fromRGBO(239, 239, 239, 1),
          length: 4,
          itemSize: 50,
          fullBorder: true,
          cursorColor: Colors.blue,
          fillColor: Color.fromRGBO(239, 239, 239, 1),
          margin: const EdgeInsets.all(12),
          onCompleted: (String value) {
            setState(() {
              _code = value;
            });
          },
          onEditing: (bool value) {
            setState(() {
              _onEditing = value;
            });
            if (!_onEditing) FocusScope.of(context).unfocus();
          },
        ),
        SizedBox(height: 40),
        InkWell(
            onTap: () async {
              if (!_onEditing) {
                dynamic response =
                    await appService.confirmPhoneSmsCode(sms_code: _code);
                if (response is String || response == null) {
                  showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: response,
                      ));
                } else {}
              }
            },
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Color.fromRGBO(239, 239, 239, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(47, 54, 67, 1)),
              ),
            )),
        SizedBox(height: 25),
        new RichText(
          text: new TextSpan(
            children: [
              new TextSpan(
                text: 'Re-send code in  ',
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              new TextSpan(
                text: ' 0:20',
                style: new TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

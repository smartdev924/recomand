import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/constants.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  final TextEditingController eCtrl = TextEditingController();
  String name = '';
  String email = '';
  String city = '';
  String CIF = '';
  String address = '';
  final _formKey = GlobalKey<FormState>();
  bool firstSubmit = false;
  bool isEmail = false;
  int selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Languages.of(context)!.oerder_pay,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                Text(
                  Languages.of(context)!.company_info,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                    child: Column(
                  children: [
                    buildCIFFormField(),
                    SizedBox(
                      height: 25,
                    ),
                    buildNameFormField(),
                    SizedBox(
                      height: 25,
                    ),
                    buildCityFormField(),
                    SizedBox(
                      height: 25,
                    ),
                    buildAddressFormField(),
                    SizedBox(
                      height: 25,
                    ),
                    buildEmailFormField(),
                  ],
                )),
                SizedBox(
                  height: 34,
                ),
                Text(
                  Languages.of(context)!.payment_method,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => {selectedPaymentMethod = 0});
                  },
                  child: Container(
                    height: 51,
                    margin: EdgeInsets.only(bottom: 17),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 243, 245, 1),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        width: 1.0,
                        // assign the color to the border color
                        color: Color.fromRGBO(218, 218, 218, 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0)),
                              color: selectedPaymentMethod == 0
                                  ? Color.fromRGBO(0, 162, 216, 1)
                                  : Color.fromRGBO(139, 139, 151, 1)),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Expanded(
                            child: Text(
                          Languages.of(context)!.credit_card,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => {selectedPaymentMethod = 1});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 17),
                    height: 51,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 243, 245, 1),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        width: 1.0,
                        // assign the color to the border color
                        color: Color.fromRGBO(218, 218, 218, 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0)),
                              color: selectedPaymentMethod == 1
                                  ? Color.fromRGBO(0, 162, 216, 1)
                                  : Color.fromRGBO(139, 139, 151, 1)),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Expanded(
                            child: Text(
                          Languages.of(context)!.payment_bank,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 243, 245, 1),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Color.fromRGBO(218, 218, 218, 1))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                Text(
                                  Languages.of(context)!.request_10,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            value: true,
                            onChanged: (newValue) {},
                            dense: true,
                            activeColor: Color.fromRGBO(0, 194, 255, 1)),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            Languages.of(context)!.subscription_desc,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(153, 153, 153, 1)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  Languages.of(context)!.paynow_01,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                new RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: Languages.of(context)!.agree,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      new TextSpan(
                        text: ' ' + Languages.of(context)!.terms_service,
                        style: new TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: new TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
              text: Languages.of(context)!.payNow,
              press: () =>
                  {GoRouter.of(context).pushNamed(APP_PAGE.home.toName)})),
    );
  }

  TextFormField buildCIFFormField() {
    return TextFormField(
      onSaved: (newName) => this.CIF = newName!,
      onChanged: (name) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      decoration: InputDecoration(
        labelText: 'CIF / CUI ( if applicable)*',
        hintText: 'CIF / CUI ( if applicable)*',
        suffixIcon: Icon(Icons.check),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newName) => this.name = newName!,
      onChanged: (name) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.name_company_02,
        hintText: Languages.of(context)!.name_company_02,
        suffixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      onSaved: (newName) => this.city = newName!,
      onChanged: (name) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.city + '*',
        hintText: Languages.of(context)!.alert_city,
        suffixIcon: Icon(Icons.location_city),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newName) => this.address = newName!,
      onChanged: (name) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.address + '*',
        hintText: Languages.of(context)!.alert_address,
        suffixIcon: Icon(Icons.location_on_sharp),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newEmail) => this.email = newEmail!,
      onChanged: (email) {
        if (email.isEmpty) {
          setState(() {
            isEmail = false;
          });
        } else if (email.isNotEmpty && !emailValidatorRegExp.hasMatch(email)) {
          setState(() {
            isEmail = false;
          });
        } else {
          setState(() {
            isEmail = true;
          });
        }
        if (firstSubmit) _formKey.currentState!.validate();
      },
      validator: (email) {
        if (email!.isEmpty) {
          return Languages.of(context)!.kEmailNullError;
        } else if (email.isNotEmpty && !emailValidatorRegExp.hasMatch(email)) {
          return Languages.of(context)!.kInvalidEmailError;
        }

        return null;
      },
      decoration: InputDecoration(
          labelText: Languages.of(context)!.email + '*',
          hintText: Languages.of(context)!.pleaseendteryouremail,
          suffixIcon: Icon(
            isEmail ? Icons.check : Icons.email_rounded,
          )),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

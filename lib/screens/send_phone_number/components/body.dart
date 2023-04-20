import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localservice/services/AppService.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/size_config.dart';
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
  List<String> dialCodeList = ['+40', '+39', '+37'];
  String countryCode = '';
  late AppService appService;
  static const List<String> list = <String>[
    'Service provider can call',
  ];
  String dropdownValue = list.first;
  TextEditingController phoneNumberInputCtrl = TextEditingController();

  @override
  void initState() {
    countryCode = dialCodeList[0];
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Text(
              Languages.of(context)!.enterPhone,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              Languages.of(context)!.phoneDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(139, 139, 151, 1),
              ),
            ),
            SizedBox(
              height: 52,
            ),
            Container(
                width: 330,
                child: Row(
                  children: [
                    Container(
                        width: 105,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(217, 217, 217, 1)),
                            color: Color.fromRGBO(243, 244, 246, 1)),
                        child: DropdownButton<String>(
                          value: countryCode,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 8,
                          isExpanded: true,
                          style: const TextStyle(
                              color: Color.fromRGBO(139, 139, 151, 1)),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          alignment: AlignmentDirectional.center,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              countryCode = value!;
                            });
                          },
                          items: dialCodeList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(217, 217, 217, 1)),
                            color: Color.fromRGBO(243, 244, 246, 1)),
                        child: TextFormField(
                          controller: phoneNumberInputCtrl,
                          onChanged: (value) {
                            setState(
                              () {
                                // selectedCityData = null;
                              },
                            );
                          },
                          validator: (value) {
                            if (value?.isEmpty == false) {}
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: true,
                            fillColor: Color.fromRGBO(242, 243, 245, 1),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(1),
                              vertical: getProportionateScreenHeight(19),
                            ),
                            hintText: Languages.of(context)!.enterPhone,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 330,
                padding: EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
                    color: Color.fromRGBO(243, 244, 246, 1)),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 8,
                  isExpanded: true,
                  style:
                      const TextStyle(color: Color.fromRGBO(139, 139, 151, 1)),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  alignment: AlignmentDirectional.center,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
              text: Languages.of(context)!.next_btn,
              press: () async {
                if (phoneNumberInputCtrl.text == "") {
                  showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: Languages.of(context)!.enterPhoneNumber,
                      ));
                  return;
                }
                dynamic response = await appService.validatePhoneNumber(
                    country_code: countryCode,
                    phone_number: phoneNumberInputCtrl.text);
                if (response is String || response == null) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: response,
                    ),
                  );
                } else {
                  if (response.data['success'] == false) {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.info(
                        message: response.data['message'],
                      ),
                    );
                  } else
                    GoRouter.of(context)
                        .pushNamed(APP_PAGE.sendPhoneNumber.toName);
                }
              })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController eCtrl = TextEditingController();
  int selectedSubscription = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16),
              width: 335,
              child: Text(
                Languages.of(context)!.choose_monthly,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 34,
            ),
            GestureDetector(
              onTap: () {
                setState(() => {selectedSubscription = 0});
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: selectedSubscription == 0
                          ? Colors.grey[100]
                          : Colors.white,
                      border:
                          Border.all(color: Color.fromRGBO(218, 218, 218, 1))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: CheckboxListTile(
                            title: Text(
                              Languages.of(context)!.request_10,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            value: selectedSubscription == 0,
                            onChanged: (newValue) {
                              setState(() => {selectedSubscription = 0});
                            },
                            dense: true,
                            activeColor: Color.fromRGBO(0, 194, 255, 1)),
                      ),
                      Divider(
                        height: 0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          Languages.of(context)!.sub_01,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.check,
                            color: Color.fromRGBO(67, 160, 71, 1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              Languages.of(context)!.on_average1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.check,
                            color: Color.fromRGBO(67, 160, 71, 1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              Languages.of(context)!.no_contract,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() => {selectedSubscription = 1});
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                      color: selectedSubscription == 1
                          ? Colors.grey[100]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border:
                          Border.all(color: Color.fromRGBO(218, 218, 218, 1))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: CheckboxListTile(
                            title: Text(
                              Languages.of(context)!.request_20,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            value: selectedSubscription == 1,
                            onChanged: (newValue) {
                              setState(() => {selectedSubscription = 1});
                            },
                            dense: true,
                            activeColor: Color.fromRGBO(0, 194, 255, 1)),
                      ),
                      Divider(
                        height: 0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          Languages.of(context)!.sub_02,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.check,
                            color: Color.fromRGBO(67, 160, 71, 1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              Languages.of(context)!.on_average2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.check,
                            color: Color.fromRGBO(67, 160, 71, 1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              Languages.of(context)!.no_contract,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() => {selectedSubscription = 2});
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                      color: selectedSubscription == 2
                          ? Colors.grey[100]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border:
                          Border.all(color: Color.fromRGBO(218, 218, 218, 1))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: CheckboxListTile(
                            title: Text(
                              Languages.of(context)!.request_35,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            value: selectedSubscription == 2,
                            onChanged: (newValue) {
                              setState(() => {selectedSubscription = 2});
                            },
                            dense: true,
                            activeColor: Color.fromRGBO(0, 194, 255, 1)),
                      ),
                      Divider(
                        height: 0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          Languages.of(context)!.sub_02,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.check,
                            color: Color.fromRGBO(67, 160, 71, 1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              Languages.of(context)!.on_average3,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.check,
                            color: Color.fromRGBO(67, 160, 71, 1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              Languages.of(context)!.no_contract,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                Languages.of(context)!.on_average4,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                Languages.of(context)!.calc_description,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
              text: Languages.of(context)!.next_btn,
              press: () => {
                    GoRouter.of(context).pushNamed(APP_PAGE.verificaiton.toName)
                  })),
    );
  }
}

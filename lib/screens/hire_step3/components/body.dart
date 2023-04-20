import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController eCtrl = TextEditingController();
  dynamic serviceList = [
    {'title': 'Ferestre termopan1', 'selected': false},
    {'title': 'Ferestre termopan2', 'selected': false},
    {'title': 'Ferestre termopan3', 'selected': false},
    {'title': 'Ferestre termopan4', 'selected': false},
    {'title': 'Ferestre termopan5', 'selected': false},
    {'title': 'Ferestre termopan7', 'selected': false},
    {'title': 'Ferestre termopan8', 'selected': false},
    {'title': 'Ferestre termopan9', 'selected': false},
  ];

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
              child: Text(
                'Select type of service :',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 15),
              width: 270,
              child: Text(
                "Receive 6 offers from SEO agencies with 1 request",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border:
                        Border.all(color: Color.fromRGBO(218, 218, 218, 1))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title of service',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            'Help us define what kind of customers you want to receive.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: serviceList.length,
                        itemBuilder: (ctx, index) => Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Color.fromRGBO(218, 218, 218, 1))),
                          child: CheckboxListTile(
                            title: Text(serviceList[index]['title']
                                .toString()), //    <-- label
                            value: serviceList[index]['selected'],
                            onChanged: (newValue) {
                              setState(() => {
                                    serviceList[index]['selected'] =
                                        !serviceList[index]['selected']
                                  });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            checkColor: Color.fromRGBO(67, 160, 71, 1),
                            activeColor: Colors.transparent,
                          ),
                        ),
                      ),
                      height: 200,
                    ),
                    Divider(),
                  ],
                )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
              text: Languages.of(context)!.next_btn.toUpperCase(),
              press: () =>
                  {GoRouter.of(context).pushNamed(APP_PAGE.home.toName)})),
    );
  }
}

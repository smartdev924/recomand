import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localservice/localization/language/languages.dart';

class MyJobsCancelCard extends StatefulWidget {
  const MyJobsCancelCard({required this.index, required this.data});
  final data;
  final index;
  // final data;
  @override
  _MyJobsCancelCardState createState() => _MyJobsCancelCardState();
}

class _MyJobsCancelCardState extends State<MyJobsCancelCard> {
  // late AppService _appService;
  @override
  void initState() {
    // _appService = Provider.of<AppService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(217, 217, 217, 0.3)),
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(widget.data['updated_on'])),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(137, 138, 143, 1)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.data['service']['name'],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: Text(Languages.of(context)!.Cancelled,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(68, 68, 68, 1),
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

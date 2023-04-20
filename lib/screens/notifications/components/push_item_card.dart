import 'package:flutter/material.dart';

class PushItemCard extends StatefulWidget {
  const PushItemCard({required this.notiItem});
  final notiItem;

  @override
  _PushItemCardState createState() => _PushItemCardState();
}

class _PushItemCardState extends State<PushItemCard> {
  DateTime selectedDate = DateTime.now();
  String dateAgo = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 34),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(0, 0, 0, 0.3),
          ),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('')),
              IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Seve your search as search agent. Automatically receive new matching ads as App notification!',
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(27, 28, 30, 1)),
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(234, 236, 249, 1),
                    ),
                    color: Color.fromRGBO(234, 236, 249, 1),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Transform.rotate(
                  angle: 20 * 3.14 / 180,
                  child: Icon(
                    Icons.notifications_active,
                    color: Color.fromRGBO(241, 99, 114, 1),
                    size: 40,
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  }
}

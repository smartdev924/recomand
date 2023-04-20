import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';

class NotficationItemCard extends StatefulWidget {
  const NotficationItemCard({required this.notiItem});
  final notiItem;

  @override
  _NotficationItemCardState createState() => _NotficationItemCardState();
}

class _NotficationItemCardState extends State<NotficationItemCard> {
  DateTime selectedDate = DateTime.now();
  String dateAgo = '';
  late AppService appService;
  @override
  void initState() {
    appService = Provider.of<AppService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await appService.markNotficationAsRead(
            notificationID: widget.notiItem['id']);
        setState(() {
          widget.notiItem['is_read'] = true;
        });
        if (widget.notiItem['type'] == 'new_offer') {
          dynamic data = widget.notiItem['route'].split('/');
          if (data.length > 2) {
            appService.selectedOfferIDfromNotification =
                int.parse(widget.notiItem['route'].split('/')[2]);
            GoRouter.of(context).pushNamed(APP_PAGE.myJobOfferid.toName);
          }
        }
        if (widget.notiItem['type'] == 'new_request') {
          GoRouter.of(context).pushNamed(APP_PAGE.directJobDetails.toName,
              params: {
                "requestID": widget.notiItem['route'].split('/')[2].toString()
              });
        }
      },
      child: Container(
          padding: EdgeInsets.only(top: 6, left: 20, right: 20, bottom: 15),
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(139, 139, 151, 0.5)),
              ),
              color: Colors.transparent),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.notiItem['message'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Color.fromRGBO(43, 44, 46, 1)
                              : Color.fromRGBO(209, 210, 212, 1)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.notiItem['type']
                          .replaceAll(RegExp('_'), ' ')
                          .toUpperCase(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(139, 139, 151, 1)),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      DateFormat('dd.MM').format(
                              DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'')
                                  .parse(widget.notiItem['updated_on'])) +
                          '. - ' +
                          DateFormat('hh:mm').format(
                              DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'')
                                  .parse(widget.notiItem['updated_on'])),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(139, 139, 151, 1)),
                    ),
                  ],
                ),
              ),
              if (widget.notiItem['is_read'] == false)
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                )
            ],
          )),
    );
  }
}

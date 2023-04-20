import 'package:flutter/material.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoaded = false;
  dynamic creditHistoryList;
  late AppService _appService;
  ScrollController historyScrollController = ScrollController();
  bool isLoadMoreHistory = false;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    getCreditHistory();
    historyScrollController.addListener(() {
      if (historyScrollController.position.pixels ==
          historyScrollController.position.maxScrollExtent) {
        if (!isLoadMoreHistory) loadMoreHistory();
      }
    });
    super.initState();
  }

  Future<void> loadMoreHistory() async {
    setState(() {
      isLoadMoreHistory = true;
    });
    dynamic response =
        await _appService.getCreditHistory(offset: creditHistoryList.length);
    if (!mounted) return;

    if (response is String || response == null) {
      setState(() {
        isLoadMoreHistory = false;
      });
      return;
    }
    setState(
      () {
        creditHistoryList.addAll(response.data['data']);
        isLoadMoreHistory = false;
      },
    );
  }

  Future<void> getCreditHistory() async {
    dynamic response = await _appService.getCreditHistory();
    if (!mounted) return;

    if (response is String || response == null) {
      creditHistoryList = null;
      setState(() {
        isLoaded = true;
      });
      return;
    }
    setState(
      () {
        creditHistoryList = response.data['data'];
      },
    );

    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: !isLoaded
          ? Center(child: CircularProgressIndicator())
          : creditHistoryList == null
              ? SizedBox()
              : Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(224, 224, 224, 1)),
                          top: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(224, 224, 224, 1)),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Text(
                              'ID',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(Languages.of(context)!.description,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(Languages.of(context)!.amount,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(Languages.of(context)!.date,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                    ),
                    if (creditHistoryList.length == 0)
                      Text(Languages.of(context)!.noCredit),
                    Flexible(
                        child: RefreshIndicator(
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: historyScrollController,
                          physics: ScrollPhysics(),
                          itemCount: creditHistoryList.length,
                          itemBuilder: (ctx, index) => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      child: Text(
                                        creditHistoryList[index]['id']
                                            .toString(),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                          creditHistoryList[index]
                                                      ['vousher_id'] ==
                                                  null
                                              ? creditHistoryList[index]['type']
                                                      .replaceAll(
                                                          RegExp('_'), ' ')
                                                      .toUpperCase() +
                                                  ' #' +
                                                  creditHistoryList[index]
                                                          ['request_id']
                                                      .toString()
                                              : creditHistoryList[index]['type']
                                                      .replaceAll(
                                                          RegExp('_'), ' ')
                                                      .toUpperCase() +
                                                  ' #' +
                                                  creditHistoryList[index]
                                                          ['vousher_id']
                                                      .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: Text(
                                          creditHistoryList[index]
                                                      ['vousher_id'] ==
                                                  null
                                              ? '-' +
                                                  creditHistoryList[index]
                                                          ['credit']
                                                      .toString()
                                              : '+' +
                                                  creditHistoryList[index]
                                                          ['credit']
                                                      .toString(),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: Text(
                                          DateFormat('dd/MM/yy').format(DateFormat(
                                                  'EEE, dd MMM yyyy HH:mm:ss \'GMT\'')
                                              .parse(creditHistoryList[index]
                                                  ['updated_on'])),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              )),
                      onRefresh: () {
                        return getCreditHistory();
                      },
                    )),
                    Container(
                        height: 40,
                        child: isLoadMoreHistory
                            ? Center(child: CircularProgressIndicator())
                            : Text(""))
                  ],
                ),
    );
  }
}

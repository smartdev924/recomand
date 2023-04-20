import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/service_item.dart';
import 'package:localservice/route/router_utils.dart';
import './section_title.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';

class ServiceList extends StatefulWidget {
  ServiceList({required this.serviceList});
  final serviceList;
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  late AppService _appService;

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 17, right: 17, top: 24),
        padding: EdgeInsets.all(10),
        child: Column(children: [
          SectionTitle(
            title: widget.serviceList['title'],
          ),
          SizedBox(height: getProportionateScreenHeight(7)),
          widget.serviceList?.length == 0 || widget.serviceList == null
              ? Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.new_releases_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    Languages.of(context)!.no_service,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ])
              : Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.0,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Color.fromRGBO(0, 0, 0, 0.1)
                              : Color.fromRGBO(79, 162, 219, 1)),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0;
                            i < widget.serviceList['services'].length;
                            i++)
                          InkWell(
                            onTap: () {
                              _appService.selectedServiceItemData =
                                  widget.serviceList['services'][i];
                              GoRouter.of(context)
                                  .pushNamed(APP_PAGE.viewService.toName);
                            },
                            child: ServiceItem(
                                serviceItem: widget.serviceList['services'][i]),
                          )
                      ],
                    ),
                  ),
                )
        ]));
  }
}

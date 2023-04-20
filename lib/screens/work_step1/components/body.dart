import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/constants.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../size_config.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController eCtrl = TextEditingController();
  dynamic serviceList = [];
  dynamic allServiceList = [];
  dynamic selectedServiceList = [];
  bool processingSelectedService = false;
  late AppService appService;
  String searchKey = '';

  @override
  void initState() {
    appService = Provider.of<AppService>(context, listen: false);
    getServiceList();
    super.initState();
  }

  Future<void> searchServiceList(String key) async {
    serviceList = [];
    for (int i = 0; i < allServiceList.length; i++) {
      if (removeDiacritics(allServiceList[i]['name'])
          .toLowerCase()
          .contains(key.toLowerCase()))
        serviceList.add({
          'name': allServiceList[i]['name'],
          "selected": false,
          'id': allServiceList[i]['id']
        });
      // if (allServiceList[i]['name']
      //     .toString()
      //     .toLowerCase()
      //     .contains(key.toLowerCase()))
      //   serviceList.add({
      //     'name': allServiceList[i]['name'],
      //     "selected": false,
      //     'id': allServiceList[i]['id']
      //   });
    }
    checkSelectedServies();
  }

  Future<void> getServiceList() async {
    final response = await appService.getAllServices();
    await appService.getMyServices1();
    if (response is String || response == null) {
      setState(() {});
    } else {
      if (!mounted) return;
      setState(() {
        dynamic data = response.data['data'];
        for (int i = 0; i < data.length; i++) {
          serviceList.add({
            'name': data[i]['name'],
            "selected": false,
            'id': data[i]['id']
          });
          allServiceList.add({
            'name': data[i]['name'],
            "selected": false,
            'id': data[i]['id']
          });
        }
        if (appService.selectedServices != null) {
          selectedServiceList = appService.selectedServices;
        }
      });
      checkSelectedServies();
    }
  }

  Future<void> checkSelectedServies() async {
    if (selectedServiceList.length == 0) return;
    if (serviceList.length == 0) return;
    for (int i = 0; i < selectedServiceList.length; i++) {
      setState(() {
        serviceList
            .removeWhere((item) => item['id'] == selectedServiceList[i]['id']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<AppService>().themeState.isDarkTheme == false
              ? Colors.white
              : context
                  .watch<AppService>()
                  .themeState
                  .customColors[AppColors.primaryBackgroundColor],
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, top: 20),
            width: 270,
            child: Text(
              Languages.of(context)!.step1_des,
              style: TextStyle(
                fontSize: 36,
                color: context
                    .watch<AppService>()
                    .themeState
                    .customColors[AppColors.primaryTextColor1],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, top: 15),
            width: 270,
            child: Text(
              Languages.of(context)!.change_anytime,
              style: TextStyle(
                fontSize: 14,
                color: context
                    .watch<AppService>()
                    .themeState
                    .customColors[AppColors.primaryTextColor1],
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
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(bottom: 11),
            child: TextFormField(
              controller: eCtrl,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    serviceList = [];
                  });
                }
                ;
                setState(() {
                  searchKey = value;
                  searchServiceList(searchKey);
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: true,
                fillColor:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Color.fromRGBO(242, 243, 245, 1)
                        : Color.fromRGBO(13, 13, 13, 1),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(1),
                  vertical: getProportionateScreenHeight(19),
                ),
                hintText: Languages.of(context)!.searchCategory,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: serviceList.length,
            itemBuilder: (ctx, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: context.watch<AppService>().themeState.isDarkTheme ==
                            false
                        ? Colors.white
                        : Color.fromRGBO(13, 13, 13, 1),
                    border: Border.all(
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? Color.fromRGBO(218, 218, 218, 1)
                            : Color.fromRGBO(13, 13, 13, 1))),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: InkWell(
                      child: Row(children: [
                        Text(
                          serviceList[index]['name'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: context
                                        .watch<AppService>()
                                        .themeState
                                        .isDarkTheme ==
                                    true
                                ? Color.fromRGBO(137, 138, 143, 1)
                                : Colors.black,
                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.chevron_right,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  true
                              ? Color.fromRGBO(137, 138, 143, 1)
                              : Colors.black,
                          size: 35,
                        )
                      ]),
                      onTap: () {
                        setState(() => {
                              eCtrl.text = "",
                              searchKey = "",
                            });
                        appService.selectedServiceToAdd = serviceList[index];

                        selectedServiceList = [];
                        selectedServiceList.add(serviceList[index]);
                        for (int i = 0;
                            i < appService.selectedServices.length;
                            i++)
                          selectedServiceList
                              .add(appService.selectedServices[i]);
                        setState(() {
                          serviceList = [];
                        });

                        // GoRouter.of(context)
                        //     .pushNamed(APP_PAGE.workStep3.toName);
                      },
                    ))),
          ),
          selectedServiceList.length != 0
              ? Container(
                  padding: EdgeInsets.only(top: 20, bottom: 13),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    Languages.of(context)!.select_service,
                    style: TextStyle(
                      fontSize: 24,
                      color: context
                          .watch<AppService>()
                          .themeState
                          .customColors[AppColors.primaryTextColor1],
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                )
              : Container(),
          selectedServiceList.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedServiceList.length,
                  itemBuilder: (ctx, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? Colors.white
                            : Color.fromRGBO(13, 13, 13, 1),
                        border: Border.all(
                            color: context
                                        .watch<AppService>()
                                        .themeState
                                        .isDarkTheme ==
                                    false
                                ? Color.fromRGBO(218, 218, 218, 1)
                                : Color.fromRGBO(13, 13, 13, 1))),
                    child: Row(
                      children: [
                        Flexible(
                          child: CheckboxListTile(
                            title: Text(
                              selectedServiceList[index]['name'].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        true
                                    ? Color.fromRGBO(137, 138, 143, 1)
                                    : Colors.black,
                              ),
                            ),
                            value: true,
                            onChanged: (newValue) async {},
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            checkColor: Color.fromRGBO(79, 162, 219, 1),
                            activeColor: Colors.transparent,
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (selectedServiceList[index]
                                      ['user_service_id'] ==
                                  null)
                                setState(() {
                                  selectedServiceList = [];
                                  selectedServiceList =
                                      appService.selectedServices;
                                });
                              else {
                                await appService.deleteMyServiceID(
                                    id: selectedServiceList[index]
                                        ['user_service_id']);
                                setState(
                                  () {
                                    selectedServiceList.removeAt(index);
                                    serviceList = allServiceList;
                                    checkSelectedServies();
                                  },
                                );
                                // if (response is String || response == null) {
                                //   showTopSnackBar(
                                //     Overlay.of(context),
                                //     CustomSnackBar.error(
                                //       message: response,
                                //     ),
                                //   );
                                // } else {
                                //   if (response.data['success'])
                                //     setState(
                                //       () {
                                //         selectedServiceList.removeAt(index);
                                //         serviceList = allServiceList;
                                //         checkSelectedServies();
                                //       },
                                //     );
                                //   else
                                //     showTopSnackBar(
                                //       Overlay.of(context),
                                //       CustomSnackBar.error(
                                //         message: response.data['message'],
                                //       ),
                                //     );
                                // }
                              }
                            },
                            icon: Icon(
                              Icons.close,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      true
                                  ? Color.fromRGBO(137, 138, 143, 1)
                                  : Colors.black,
                              size: 30,
                            )),
                        SizedBox(width: 10)
                      ],
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 20,
          )
        ],
      )),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
              text: Languages.of(context)!.next_btn,
              press: () async {
                if (selectedServiceList.length == 0) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.info(
                      message: Languages.of(context)!.alert_select_service,
                    ),
                  );
                  return;
                }
                GoRouter.of(context).pushNamed(APP_PAGE.workStep3.toName);
              })),
    );
  }
}

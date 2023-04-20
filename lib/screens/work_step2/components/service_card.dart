import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';

class ServiceCard extends StatefulWidget {
  final serviceData;
  ServiceCard({required this.serviceData});

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  late AppService _appService;
  dynamic subServiceList = [];

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    for (int i = 0; i < widget.serviceData['sub'].length; i++) {
      setState(() {
        dynamic data = {
          'id': widget.serviceData['sub'][i]['id'],
          'name': widget.serviceData['sub'][i]['name'],
          'selected': true
        };
        subServiceList.add(data);
        addOrRemoveSubServiceData(data);
      });
    }
    super.initState();
  }

  addOrRemoveSubServiceData(data) {
    if (data['selected'] == true) {
      _appService.selectedSubServiceList.add({'id': data['id']});
    } else {
      _appService.selectedSubServiceList
          .removeWhere((element) => element["id"] == data['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Color.fromRGBO(218, 218, 218, 1))),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.serviceData['name'] != null
                          ? widget.serviceData['name']
                          : "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      Languages.of(context)!.step1_des,
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
                  itemCount: subServiceList.length,
                  itemBuilder: (ctx, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Color.fromRGBO(218, 218, 218, 1))),
                    child: CheckboxListTile(
                      title: Text(subServiceList[index]['name']
                          .toString()), //    <-- label
                      value: subServiceList[index]['selected'],
                      // value: false,
                      onChanged: (newValue) {
                        setState(() => {
                              subServiceList[index]['selected'] =
                                  !subServiceList[index]['selected'],
                              addOrRemoveSubServiceData(subServiceList[index])
                            });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      checkColor: Color.fromRGBO(67, 160, 71, 1),
                      activeColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Divider(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() => {
                            for (int i = 0; i < subServiceList.length; i++)
                              {subServiceList[i]['selected'] = false}
                          });
                    },
                    child: Text(
                      Languages.of(context)!.eliminate,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(241, 99, 114, 1)),
                    ),
                  ))
            ],
          ),
        ));
  }
}

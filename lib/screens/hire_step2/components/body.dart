import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/constants.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _currentStep = 0;
  dynamic serviceList = [];
  dynamic allServiceList = [];
  dynamic subServiceList = [];
  dynamic cityList = [];
  dynamic selectedCity = 0;
  dynamic selectedCityData = null;
  dynamic selectedService = null;
  dynamic selectedServiceData = null;
  dynamic questionBody = {};
  String requestID = '';
  String whenNeed = 'soon_as_possible';
  dynamic _selectedSubService = 0;
  late AppService appService;
  String searchKey = '';
  String description = '';
  String phone = '';
  bool isPublishing = false;
  final TextEditingController searchServiceTextFormCtrl =
      TextEditingController();
  final TextEditingController nameTextInputCtrl = TextEditingController();
  final TextEditingController phoneInputCtrl = TextEditingController();
  final TextEditingController searchCityCtrl = TextEditingController();
  final TextEditingController descriptionInputCtrl = TextEditingController();

  @override
  void initState() {
    appService = Provider.of<AppService>(context, listen: false);
    getServiceList();
    super.initState();
  }

  Future<void> searchCities(String key) async {
    final response = await appService.locationAutoComplete(city: key);
    if (response is String || response == null) {
      setState(() {});
    } else {
      setState(() {
        dynamic data = response.data['data'];
        for (int i = 0; i < data.length; i++) {
          cityList.add({
            'selected': false,
            'id': data[i]['city']['id'],
            'name': data[i]['city']['name'] + ', ' + data[i]['city']['region'],
            'data': data[i]
          });
        }
      });
      if (cityList.length == 0) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: Languages.of(context)!.alert_nocity,
          ),
        );
      }
    }
  }

  Future<void> getServiceList() async {
    final response = await appService.getAllServices();
    if (response is String || response == null) {
      setState(() {});
    } else {
      setState(() {
        dynamic data = response.data['data'];
        for (int i = 0; i < data.length; i++) {
          serviceList.add({
            'name': data[i]['name'],
            "selected": false,
            'id': data[i]['id'],
          });
          allServiceList.add({
            'name': data[i]['name'],
            "selected": false,
            'id': data[i]['id'],
          });
        }
      });
    }
  }

  Future<void> getSubServiceList() async {
    if (selectedService == [] || selectedService == null) return;
    setState(() {
      subServiceList = [];
    });
    final response =
        await appService.getServiceById(serviceID: selectedService['id']);
    if (response is String || response == null) {
      setState(() {});
    } else {
      setState(() {
        dynamic data = response.data;
        selectedServiceData = response.data;
        questionBody = selectedServiceData['questions'][0];
        if (selectedServiceData['questions'][0].length != 0) {
          for (int i = 0; i < questionBody.length; i++) {
            if (questionBody[i]['question_type'] == 'checkbox') {
              questionBody[i]!['value'] = [];
            } else {
              questionBody[i]!['value'] = "";
            }
          }
        }
        for (int i = 0; i < data['sub'].length; i++) {
          setState(() {
            dynamic subServiceData = {
              'id': data['sub'][i]['id'],
              'name': data['sub'][i]['name'],
              'selected': true
            };
            subServiceList.add(subServiceData);
          });
        }
      });
    }
  }

  Future<void> searchServiceList(String key) async {
    serviceList = [];
    for (int i = 0; i < allServiceList.length; i++) {
      if (removeDiacritics(allServiceList[i]['name'])
          .toLowerCase()
          .contains(key.toLowerCase())) serviceList.add(allServiceList[i]);
      // if (allServiceList[i]['name']
      //     .toString()
      //     .toLowerCase()
      //     .contains(key.toLowerCase())) serviceList.add(allServiceList[i]);
    }
  }

  tapped(int step) {
    if (step == 0) {
      setState(() {
        _selectedSubService = 0;
        searchServiceTextFormCtrl.text = "";
        serviceList = [];
        selectedServiceData = null;
        phoneInputCtrl.text = '';
        searchCityCtrl.text = '';
        nameTextInputCtrl.text = "";
        descriptionInputCtrl.text = '';
        selectedCityData = null;
      });
    } else if (step == 1) {
      phoneInputCtrl.text = '';
      searchCityCtrl.text = '';
      selectedCityData = null;
      nameTextInputCtrl.text = "";
      descriptionInputCtrl.text = '';
      selectedServiceData = null;
    }
    setState(() => _currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Stepper(
                  margin: EdgeInsets.only(left: 50, right: 20),
                  type: StepperType.vertical,
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return Container();
                  },
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  steps: <Step>[
                    /*first steop*/
                    Step(
                      title: _currentStep == 0
                          ? new Text(
                              '1. ' + Languages.of(context)!.what_looking,
                              style: TextStyle(fontSize: 30))
                          : new Text(
                              '1. ' + Languages.of(context)!.what_looking,
                              style: TextStyle(fontSize: 16)),
                      content: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: TextFormField(
                              controller: searchServiceTextFormCtrl,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    serviceList = [];
                                  });
                                } else {
                                  setState(() {
                                    searchKey = value;
                                    searchServiceList(searchKey);
                                  });
                                }
                              },
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
                                hintText: Languages.of(context)!.searchCategory,
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          searchKey == ""
                              ? Container()
                              : Container(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: serviceList.length,
                                    itemBuilder: (ctx, index) => Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 4),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedService =
                                                    serviceList[index];
                                                getSubServiceList();
                                                _currentStep = 1;
                                              });
                                            },
                                            child: Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.0),
                                                    border: Border.all(
                                                        color: Color.fromRGBO(
                                                            218, 218, 218, 1))),
                                                child: Text(
                                                  serviceList[index]['name']
                                                      .toString(),
                                                )))),
                                  ),
                                ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),

                    /** second step */
                    Step(
                      title: _currentStep == 1
                          ? new Text(
                              '2. ' +
                                  Languages.of(context)!.select_service +
                                  ' :',
                              style: TextStyle(fontSize: 24))
                          : new Text(
                              '2. ' +
                                  Languages.of(context)!.select_service +
                                  ' :',
                              style: TextStyle(fontSize: 16)),
                      content: Column(children: <Widget>[
                        subServiceList.length == 0
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(218, 218, 218, 1))),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            selectedService != null
                                                ? Text(
                                                    selectedService['name'] !=
                                                            null
                                                        ? selectedService[
                                                            'name']
                                                        : "",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : Text(""),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: subServiceList.length,
                                          itemBuilder: (ctx, index) =>
                                              Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        218, 218, 218, 1))),
                                            child: RadioListTile(
                                              groupValue: _selectedSubService,

                                              title: Text(subServiceList[index]
                                                      ['name']
                                                  .toString()), //    <-- label
                                              value: index,
                                              // value: false,
                                              onChanged: (newValue) {
                                                setState(() => {
                                                      _selectedSubService =
                                                          newValue
                                                      // addOrRemoveSubServiceData(
                                                      //     subServiceList[index])
                                                    });
                                              },
                                              activeColor: Color.fromRGBO(
                                                  0, 194, 255, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            bottom: 10,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() => {
                                                    for (int i = 0;
                                                        i <
                                                            subServiceList
                                                                .length;
                                                        i++)
                                                      {
                                                        subServiceList[i]
                                                            ['selected'] = false
                                                      }
                                                  });
                                            },
                                            child: Text(
                                              Languages.of(context)!
                                                  .remove_service,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      241, 99, 114, 1)),
                                            ),
                                          )),
                                    ])),
                        SizedBox(
                          height: 10,
                        ),
                        subServiceList.length == 0
                            ? Container()
                            : DefaultButton(
                                text: Languages.of(context)!.next_btn,
                                press: () {
                                  bool flag = false;
                                  for (int i = 0;
                                      i < subServiceList.length;
                                      i++) {
                                    if (subServiceList[i]['selected'] == true)
                                      flag = true;
                                  }
                                  if (flag == false) return;
                                  setState(() {
                                    _currentStep = 2;
                                  });
                                },
                              )
                      ]),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),

                    /** Third Step */
                    Step(
                      title: _currentStep == 2
                          ? new Text(
                              '3. ' +
                                  Languages.of(context)!.request_quote +
                                  ' ' +
                                  (subServiceList.length != 0
                                      ? subServiceList[_selectedSubService]
                                          ['name']
                                      : ""),
                              style: TextStyle(fontSize: 24))
                          : new Text(
                              '3. ' +
                                  Languages.of(context)!.request_quote +
                                  ' ' +
                                  (subServiceList.length != 0
                                      ? subServiceList[_selectedSubService]
                                          ['name']
                                      : ""),
                              style: TextStyle(fontSize: 16)),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: nameTextInputCtrl,
                            onChanged: (value) {},
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
                                horizontal: getProportionateScreenWidth(10),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              hintText: Languages.of(context)!.name_company,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: phoneInputCtrl,
                            onChanged: (value) {},
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
                                horizontal: getProportionateScreenWidth(10),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              hintText: Languages.of(context)!.phone,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: searchCityCtrl,
                            onChanged: (value) {
                              setState(
                                () {
                                  selectedCityData = null;
                                },
                              );
                            },
                            validator: (value) {
                              if (value?.isEmpty == false) {}
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                cityList = [];
                              });
                              searchCities(value);
                            },
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
                              hintText: Languages.of(context)!.city,
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                                " ( " + Languages.of(context)!.input_3 + " )",
                                style: TextStyle(color: Colors.grey[700])),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cityList.length,
                              itemBuilder: (ctx, index) => Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              218, 218, 218, 1))),
                                  child: InkWell(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on_outlined),
                                            Text(cityList[index]['name'])
                                          ],
                                        )),
                                    onTap: () {
                                      setState(() {
                                        selectedCity = index;
                                        selectedCityData =
                                            cityList[index]['data'];
                                        searchCityCtrl.text =
                                            cityList[index]['name'];
                                        cityList = [];
                                      });
                                    },
                                  )
                                  // child: RadioListTile(
                                  //   title: Text(
                                  //       cityList[index]['name']), //    <-- label
                                  //   value: index,
                                  //   groupValue: selectedCity,
                                  //   onChanged: (newValue) {
                                  //     setState(() => {selectedCity = newValue});
                                  //   },
                                  //   activeColor: Color.fromRGBO(67, 160, 71, 1),
                                  // ),
                                  ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(Languages.of(context)!.when_service,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RadioListTile(
                              title: Text(Languages.of(context)!.asap),
                              value: "soon_as_possible",
                              groupValue: whenNeed,
                              onChanged: (value) {
                                setState(() {
                                  whenNeed = value.toString();
                                });
                              },
                              activeColor: Color.fromRGBO(0, 194, 255, 1)),
                          RadioListTile(
                              title: Text(Languages.of(context)!.flexible),
                              value: "flexible",
                              groupValue: whenNeed,
                              onChanged: (value) {
                                setState(() {
                                  whenNeed = value.toString();
                                });
                              },
                              activeColor: Color.fromRGBO(0, 194, 255, 1)),
                          SizedBox(
                            height: 10,
                          ),
                          selectedServiceData == null ||
                                  selectedServiceData['questions'].length == 0
                              ? Container()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: selectedServiceData['questions'][0]
                                      .length,
                                  itemBuilder: (ctx, index) => Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            selectedServiceData['questions'][0]
                                                [index]['question_text'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (selectedServiceData['questions'][0]
                                                [index]['question_type'] ==
                                            'integer')
                                          TextFormField(
                                              onChanged: (number) {
                                                setState(() {
                                                  questionBody[index]['value'] =
                                                      number.toString();
                                                });
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              onSaved: (newval) {},
                                              validator: (num) {
                                                if (num!.isEmpty) {
                                                  return Languages.of(context)!
                                                      .filedMandatory;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                filled: true,
                                                fillColor: Color.fromRGBO(
                                                    242, 243, 245, 1),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          10),
                                                  vertical:
                                                      getProportionateScreenHeight(
                                                          19),
                                                ),
                                                hintText: Languages.of(context)!
                                                    .integeronly,
                                              ))
                                        else if (selectedServiceData[
                                                    'questions'][0][index]
                                                ['question_type'] ==
                                            'float')
                                          TextFormField(
                                              onChanged: (number) {
                                                setState(() {
                                                  questionBody[index]['value'] =
                                                      number.toString();
                                                });
                                              },
                                              inputFormatters: [
                                                // FilteringTextInputFormatter
                                                //     .digitsOnly
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d+\.?\d{0,2}')),
                                              ],
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              onSaved: (newval) {},
                                              validator: (num) {
                                                if (num!.isEmpty) {
                                                  return Languages.of(context)!
                                                      .filedMandatory;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                filled: true,
                                                fillColor: Color.fromRGBO(
                                                    242, 243, 245, 1),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          10),
                                                  vertical:
                                                      getProportionateScreenHeight(
                                                          19),
                                                ),
                                              ))
                                        else if (selectedServiceData[
                                                    'questions'][0][index]
                                                ['question_type'] ==
                                            'checkbox')
                                          Container(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: selectedServiceData[
                                                          'questions'][0][index]
                                                      ['questions_options'][0]
                                                  .length,
                                              itemBuilder: (ctx, index1) =>
                                                  Container(
                                                child: CheckboxListTile(
                                                  title: Text(selectedServiceData[
                                                                      'questions']
                                                                  [0][index][
                                                              'questions_options']
                                                          [0][index1]
                                                      .toString()), //    <-- label
                                                  value: questionBody[index]
                                                          ['value']
                                                      .contains(selectedServiceData[
                                                                      'questions']
                                                                  [0][index][
                                                              'questions_options']
                                                          [0][index1]),
                                                  // value: false,
                                                  onChanged: (newValue) {
                                                    setState(() => {
                                                          if (newValue == true)
                                                            {
                                                              // if not exist, add string
                                                              questionBody[
                                                                          index]
                                                                      ['value']
                                                                  .add(selectedServiceData['questions']
                                                                              [
                                                                              0]
                                                                          [
                                                                          index]['questions_options']
                                                                      [
                                                                      0][index1])
                                                            }
                                                          else
                                                            {
                                                              // pop up string
                                                              questionBody[
                                                                          index]
                                                                      ['value']
                                                                  .removeWhere(
                                                                      (str) {
                                                                return str ==
                                                                    selectedServiceData['questions'][0][index]
                                                                            [
                                                                            'questions_options'][0]
                                                                        [
                                                                        index1];
                                                              })
                                                            }
                                                        });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  dense: true,
                                                  checkColor: Color.fromRGBO(
                                                      79, 162, 219, 1),
                                                  activeColor:
                                                      Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          )
                                        else if (selectedServiceData[
                                                    'questions'][0][index]
                                                ['question_type'] ==
                                            'radio')
                                          Container(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: selectedServiceData[
                                                          'questions'][0][index]
                                                      ['questions_options'][0]
                                                  .length,
                                              itemBuilder: (ctx, index1) =>
                                                  Container(
                                                child: RadioListTile(
                                                    title: Text(selectedServiceData['questions']
                                                                    [0][index]
                                                                ['questions_options']
                                                            [0][index1]
                                                        .toString()),
                                                    value: selectedServiceData['questions']
                                                                    [0][index]
                                                                ['questions_options']
                                                            [0][index1]
                                                        .toString(),
                                                    groupValue: questionBody[index]
                                                        ['value'],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        questionBody[index]
                                                            ['value'] = value;
                                                      });
                                                    },
                                                    activeColor: Color.fromRGBO(
                                                        0, 194, 255, 1)),
                                              ),
                                            ),
                                          )
                                        else if (selectedServiceData[
                                                    'questions'][0][index]
                                                ['question_type'] ==
                                            'text')
                                          TextFormField(
                                            // controller: searchCityCtrl,
                                            onChanged: (value) {
                                              setState(() {
                                                questionBody[index]['value'] =
                                                    value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              filled: true,
                                              fillColor: Color.fromRGBO(
                                                  242, 243, 245, 1),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        10),
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        19),
                                              ),
                                              // hintText: "Search for a city",
                                            ),
                                          )
                                        else if (selectedServiceData[
                                                    'questions'][0][index]
                                                ['question_type'] ==
                                            'textarea')
                                          TextFormField(
                                            // controller: descriptionInputCtrl,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 5,
                                            maxLength: 500,
                                            onChanged: (value) {
                                              setState(() {
                                                questionBody[index]['value'] =
                                                    value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              filled: true,
                                              fillColor: Color.fromRGBO(
                                                  242, 243, 245, 1),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        10),
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        15),
                                              ),
                                              hintText: Languages.of(context)!
                                                  .inputAnswer,
                                            ),
                                          )
                                        else if (selectedServiceData[
                                                    'questions'][0][index]
                                                ['question_type'] ==
                                            'unit')
                                          TextFormField(
                                              onChanged: (number) {
                                                setState(() {
                                                  questionBody[index]['value'] =
                                                      number.toString();
                                                });
                                              },
                                              inputFormatters: [
                                                // FilteringTextInputFormatter
                                                //     .digitsOnly
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d+\.?\d{0,2}')),
                                              ],
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              onSaved: (newval) {},
                                              validator: (num) {
                                                if (num!.isEmpty) {
                                                  return Languages.of(context)!
                                                      .filedMandatory;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                filled: true,
                                                fillColor: Color.fromRGBO(
                                                    242, 243, 245, 1),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          10),
                                                  vertical:
                                                      getProportionateScreenHeight(
                                                          19),
                                                ),
                                                suffixText: selectedServiceData[
                                                        'questions'][0][index]
                                                    ['question_value'],
                                              ))
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            child: TextFormField(
                              controller: descriptionInputCtrl,
                              keyboardType: TextInputType.multiline,
                              maxLines: 16,
                              maxLength: 1000,
                              onChanged: (value) {},
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
                                  horizontal: getProportionateScreenWidth(10),
                                  vertical: getProportionateScreenHeight(15),
                                ),
                                hintText: Languages.of(context)!.description,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          isPublishing
                              ? CircularProgressIndicator()
                              : DefaultButton(
                                  text: Languages.of(context)!.publish_btn,
                                  press: () async {
                                    if (nameTextInputCtrl.text == "") {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                            message: Languages.of(context)!
                                                .alert_name),
                                      );
                                      return;
                                    }

                                    if (phoneInputCtrl.text == "") {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                            message: Languages.of(context)!
                                                .alert_phone),
                                      );
                                      return;
                                    }

                                    if (selectedCityData == null) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                            message: Languages.of(context)!
                                                .alert_city),
                                      );
                                      return;
                                    }
                                    if (descriptionInputCtrl.text == "") {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                            message: Languages.of(context)!
                                                .alert_description),
                                      );
                                      return;
                                    }
                                    if (selectedServiceData['questions'] !=
                                            null &&
                                        selectedServiceData['questions'][0]
                                                .length !=
                                            0) {
                                      for (int i = 0;
                                          i <
                                              selectedServiceData['questions']
                                                      [0]
                                                  .length;
                                          i++) {
                                        if (selectedServiceData['questions'][0]
                                                [i]['question_type'] ==
                                            'checkbox') {
                                          if (questionBody[i]['value'].length ==
                                              0) {
                                            showTopSnackBar(
                                              Overlay.of(context),
                                              CustomSnackBar.error(
                                                message: Languages.of(context)!
                                                        .alert_answer +
                                                    ' "' +
                                                    selectedServiceData[
                                                            'questions'][0][i]
                                                        ['question_text'] +
                                                    '"',
                                              ),
                                            );
                                            return;
                                          }
                                        } else {
                                          if (questionBody[i]['value'] == "") {
                                            showTopSnackBar(
                                              Overlay.of(context),
                                              CustomSnackBar.error(
                                                  message: Languages.of(
                                                              context)!
                                                          .alert_answer +
                                                      ' "' +
                                                      selectedServiceData[
                                                              'questions'][0][i]
                                                          ['question_text'] +
                                                      '"'),
                                            );
                                            return;
                                          }
                                          ;
                                        }
                                      }
                                    }
                                    // publish code here
                                    setState(() {
                                      isPublishing = true;
                                    });

                                    setState(() {
                                      isPublishing = false;
                                    });
                                  },
                                ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),

                    /**Last Step */
                    Step(
                        title: Text(Languages.of(context)!.request_success,
                            style: TextStyle(fontSize: 16)),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                        content: Column(children: <Widget>[
                          Image.asset(
                            'assets/images/success.png',
                            fit: BoxFit.contain,
                            width: 184,
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          Text(Languages.of(context)!.request_success,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                              Languages.of(context)!.tip_id + ' # ' + requestID,
                              style: TextStyle(
                                  color: Color.fromRGBO(15, 203, 161, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 9,
                          ),
                          SizedBox(
                            width: 220,
                            child: Text(Languages.of(context)!.success_thankyou,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(138, 141, 159, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultButton(
                              text: Languages.of(context)!.gohomepage,
                              press: () {
                                GoRouter.of(context)
                                    .pushNamed(APP_PAGE.home.toName);
                              })
                        ]))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/components/gray_button.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../size_config.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late int _currentStep = 1;
  late int _maxStep = 7;
  late int _questionStep = 1;
  late String selected_priority = '';
  late int priority_coin = 0;
  String selected_city = "";
  bool loadingCityData = false;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late int descriptionLength = 0;
  dynamic imageList = [];
  dynamic whenNeedList = [];
  late String whenNeed = '';
  DateTime selectedDate = DateTime.now();
  TextEditingController descriptionInputCtrl = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController searchCityCtrl = TextEditingController();
  TextEditingController phoneNumberInputCtrl = TextEditingController();

  dynamic city = null;
  TimeOfDay selectedTime = TimeOfDay.now();

  static const List<String> callList = <String>[
    'allow_contacts',
    'only_offers',
    'only_phone',
    'only_whatsapp'
  ];

  String dropdownValue = callList.first;
  List<String> dialCodeList = [];
  String countryCode = '';
  dynamic cityList = [];
  dynamic selectedServiceData = null;
  dynamic questionBody = {};
  dynamic validation = null;
  String latitude = '', longitude = '';
  late AppService appService;

  bool uploadingImage = false;
  bool sendingRequest = false;
  bool loadingLocation = false;
  bool standard = false;
  bool loadingFirst = false;

  @override
  void initState() {
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _timeController.text = DateFormat('hh:mm').format(DateTime.now());
    appService = Provider.of<AppService>(context, listen: false);

    setState(
      () {
        loadingFirst = true;
        validation = appService.selectedServiceItemData['validation'];
        for (int i = 0; i < validation['country_phone'].length; i++) {
          dialCodeList.add(validation['country_phone'][i]['name'] +
              ' ' +
              validation['country_phone'][i]['prefix']);
        }
        countryCode = dialCodeList[0];
        selected_priority =
            appService.selectedServiceItemData['priority_options'][0]['TYPE'];
        priority_coin =
            appService.selectedServiceItemData['priority_options'][0]['CREDIT'];
      },
    );
    getConfig();
    getSubServiceList();
    super.initState();
  }

  Future<void> searchCities(String key) async {
    setState(() {
      cityList = [];
      loadingCityData = true;
    });
    final response = await appService.locationAutoComplete(city: key);

    if (response is String || response == null) {
    } else {
      setState(() {
        cityList = response.data['data'];
      });
    }
    setState(() {
      loadingCityData = false;
    });
  }

  @override
  void dispose() {
    descriptionInputCtrl.dispose();
    _dateController.dispose();
    _timeController.dispose();
    searchCityCtrl.dispose();
    phoneNumberInputCtrl.dispose();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await _geolocatorPlatform.openLocationSettings();

      latitude = 'Location services';
      longitude = 'are disabled';

      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        await _geolocatorPlatform.openLocationSettings();
        latitude = 'Permission';
        longitude = 'denied';
        return;
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      latitude = 'Permission';
      longitude = 'permanently denied';
      await _geolocatorPlatform.openAppSettings();

      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position _position = await Geolocator.getCurrentPosition();
    setState(() {
      longitude = _position.longitude.toString();
      latitude = _position.latitude.toString();
    });
  }

  Future<void> getSubServiceList() async {
    final response = await appService.getServiceById(
        serviceID: appService.selectedServiceItemData['id']);
    if (!mounted) return;
    if (response is String || response == null) {
      setState(() {
        _maxStep = 7;
        _questionStep = -1;
        loadingFirst = false;
      });
    } else {
      setState(() {
        selectedServiceData = response.data;
        questionBody = selectedServiceData['questions'][0];
        if (selectedServiceData != null && questionBody.length != 0) {
          for (int i = 0; i < questionBody.length; i++) {
            if (questionBody[i]['question_type'] == 'checkbox') {
              questionBody[i]!['value'] = [];
            } else {
              questionBody[i]!['value'] = "";
            }
          }
          _maxStep = 7 + questionBody.length as int;
        } else {
          _maxStep = 7;
          _questionStep = -1;
        }
        loadingFirst = false;
      });
    }
  }

  Future<void> getConfig() async {
    dynamic response = await appService.getWhenNeedConfig();
    if (response is String || response == null) {
      return;
    } else {
      whenNeedList = response.data['request_options'];
      setState(() {});
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2022),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (picked_s != null) {
      var df = DateFormat("hh:mm");
      var dt = df.parse(picked_s.format(context));
      setState(() {
        _timeController.text = DateFormat('hh:mm').format(dt);
      });
    }
  }

  // Implementing the image picker
  Future<void> _openFilePicker() async {
    FilePickerResult? images = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'bmp',
        'gif',
      ],
    );
    if (images != null) {
      final files = images.paths.map((path) => File(path!)).toList();
      setState(() => {uploadingImage = true});
      await Future.forEach(files, (image) async {
        dynamic data = image;

        dynamic response = await appService.addServiceImage(
          serviceImage: File(data.path),
        );
        if (response is String || response == null) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: response,
            ),
          );
        } else {
          setState(() {
            imageList.add({
              'filename': response.data['filename'],
              'link': response.data['link']
            });
          });
        }
      });

      setState(() => {uploadingImage = false});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        backgroundColor:
            context.watch<AppService>().themeState.isDarkTheme == false
                ? Colors.white
                : context
                    .watch<AppService>()
                    .themeState
                    .customColors[AppColors.primaryBackgroundColor],
        body: SingleChildScrollView(
            child: Column(children: [
          // step progress bar
          if (!loadingFirst)
            Container(
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromRGBO(217, 217, 217, 1)),
                  ),
                ),
                child: StepProgressIndicator(
                  totalSteps: _maxStep,
                  currentStep: _currentStep,
                  size: 8,
                  padding: 0,
                  selectedColor: _maxStep == _currentStep
                      ? Color.fromRGBO(76, 217, 100, 1)
                      : Color.fromRGBO(79, 162, 219, 1),
                  unselectedColor: Colors.white,
                )),

          if (!loadingFirst)
            Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 33),
                child: Column(
                  children: [
                    if (_currentStep == _maxStep - 6)
                      Column(
                        children: [
                          Text(
                            Languages.of(context)!.heading_request,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Stack(children: [
                            TextFormField(
                              controller: descriptionInputCtrl,
                              keyboardType: TextInputType.multiline,
                              maxLines: 7,
                              maxLength: validation['description_max'],
                              buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  maxLength}) {
                                return Container(
                                  transform:
                                      Matrix4.translationValues(0, -30, 0),
                                  child: Text("$currentLength/$maxLength"),
                                );
                              },
                              onChanged: (value) {
                                setState(() {
                                  descriptionLength = value.length;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                  gapPadding: 0,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                fillColor: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Color.fromRGBO(242, 243, 245, 1)
                                    : Colors.black87,
                                contentPadding: EdgeInsets.only(
                                  top: 10,
                                  right: 15,
                                  left: 15,
                                  bottom: 25,
                                ),
                                isDense: true,
                                hintText:
                                    Languages.of(context)!.valid_question1,
                              ),
                            ),
                            Positioned(
                                bottom: 20,
                                width: MediaQuery.of(context).size.width,
                                child: StepProgressIndicator(
                                  totalSteps: validation['description_min'],
                                  currentStep: descriptionLength <
                                          validation['description_min']
                                      ? descriptionLength
                                      : validation['description_min'],
                                  size: 8,
                                  padding: 0,
                                  selectedColor: descriptionLength < 25
                                      ? Color.fromRGBO(232, 104, 111, 1)
                                      : descriptionLength <
                                              validation['description_min']
                                          ? Color.fromRGBO(241, 185, 41, 1)
                                          : Color.fromRGBO(76, 217, 100, 1),
                                  unselectedColor: Colors.white,
                                )),
                          ]),
                          descriptionLength < 25
                              ? Container(
                                  margin: EdgeInsets.only(top: 22),
                                  width: double.infinity,
                                  child: Text(
                                    descriptionLength == 0
                                        ? ""
                                        : Languages.of(context)!
                                            .valid_question2,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromRGBO(232, 104, 111, 1)),
                                  ),
                                )
                              : descriptionLength <
                                      validation['description_min']
                                  ? Container(
                                      margin: EdgeInsets.only(top: 22),
                                      width: double.infinity,
                                      child: Text(
                                        Languages.of(context)!.valid_question3,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                241, 185, 41, 1)),
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 22),
                                      child: Text(
                                        Languages.of(context)!.valid_question3,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                76, 217, 100, 1)),
                                      ),
                                    )
                        ],
                      )
                    else if (_currentStep == _maxStep - 5)
                      Column(
                        children: [
                          Text(
                            Languages.of(context)!.image_question,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 53,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 110,
                                          childAspectRatio: 1 / 1,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemCount: imageList.length + 1,
                                  // itemCount: imageList.length + 1,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return index > 0
                                        ? Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child:
                                                        ExtendedImage.network(
                                                      imageList[index - 1]
                                                          ['link'],
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    ),
                                                  )),
                                              Positioned(
                                                  top: -5,
                                                  right: -5,
                                                  child: InkWell(
                                                      onTap: (() {
                                                        setState(() {
                                                          imageList.removeAt(
                                                              index - 1);
                                                        });
                                                      }),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.red[400],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        width: 21,
                                                        height: 21,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 18,
                                                          color: Colors.grey,
                                                        ),
                                                      ))),
                                            ],
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        217, 217, 217, 1)),
                                                color: context
                                                            .watch<AppService>()
                                                            .themeState
                                                            .isDarkTheme ==
                                                        false
                                                    ? Color.fromRGBO(
                                                        243, 244, 246, 1)
                                                    : Colors.black87),
                                            alignment: Alignment.center,
                                            child: uploadingImage
                                                ? CircularProgressIndicator()
                                                : IconButton(
                                                    icon: Icon(Icons.add,
                                                        color: Color.fromRGBO(
                                                            217, 217, 217, 1)),
                                                    onPressed: () {
                                                      // _openImagePicker();

                                                      if (uploadingImage ==
                                                          false) {
                                                        _openFilePicker();
                                                      }
                                                    },
                                                  ),
                                          );
                                  })),
                        ],
                      )
                    else if (_currentStep == _maxStep - 4)
                      Column(
                        children: [
                          Text(
                            Languages.of(context)!.where_location,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          if (!kIsWeb && !Platform.isWindows)
                            InkWell(
                                onTap: (() async {
                                  await _determinePosition();
                                  if (double.tryParse(latitude) == null) {
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                        message: Languages.of(context)!
                                            .location_validation,
                                      ),
                                    );
                                    return;
                                  } else {
                                    setState(
                                      () {
                                        loadingLocation = true;
                                      },
                                    );
                                    dynamic response =
                                        await appService.getMyLocation(
                                            latitude: latitude,
                                            longitude: longitude);
                                    setState(
                                      () {
                                        loadingLocation = false;
                                        selected_city =
                                            response.data['address'];
                                        if (response.data['city'] != null) {
                                          city = response.data['city'];
                                        }
                                      },
                                    );
                                  }
                                }),
                                child: loadingLocation
                                    ? CircularProgressIndicator()
                                    : Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                217, 217, 217, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color:
                                              Color.fromRGBO(243, 244, 246, 1),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 6),
                                        child: Text(
                                          Languages.of(context)!.userMyLocation,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  43, 44, 46, 1)),
                                        ),
                                      )),
                          SizedBox(
                            height: 38,
                          ),
                          selected_city.isNotEmpty
                              ? ListTile(
                                  tileColor: context
                                              .watch<AppService>()
                                              .themeState
                                              .isDarkTheme ==
                                          true
                                      ? Color.fromARGB(255, 17, 17, 17)
                                      : Color.fromRGBO(243, 244, 246, 1),
                                  title: Text(selected_city),
                                  trailing: InkWell(
                                    child: Icon(
                                      Icons.close,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selected_city = "";
                                      });
                                    },
                                  ),
                                )
                              : TextFormField(
                                  controller: searchCityCtrl,
                                  onChanged: (value) {
                                    if (value == "") {
                                      setState(() {
                                        cityList = [];
                                      });
                                    }
                                    if (value.toString().length > 2) {
                                      searchCities(value);
                                    }
                                    setState(
                                      () {
                                        // selectedCityData = null;
                                      },
                                    );
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty == false) {}
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {},
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    filled: true,
                                    fillColor: context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme ==
                                            false
                                        ? Color.fromRGBO(242, 243, 245, 1)
                                        : Colors.black87,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(1),
                                      vertical:
                                          getProportionateScreenHeight(19),
                                    ),
                                    hintText: Languages.of(context)!.enterCity,
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          loadingCityData
                              ? CircularProgressIndicator()
                              : cityList.length == 0
                                  ? Container()
                                  : Container(
                                      height: 300,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: cityList.length,
                                          itemBuilder: (ctx, index) => InkWell(
                                                onTap: () async {
                                                  searchCityCtrl.text = '';

                                                  selected_city =
                                                      cityList[index]['city']
                                                              ['name'] +
                                                          ', ' +
                                                          cityList[index]
                                                                  ['city']
                                                              ['region'];
                                                  latitude = cityList[index]
                                                          ['city']['lat']
                                                      .toString();
                                                  longitude = cityList[index]
                                                          ['city']['lon']
                                                      .toString();
                                                  city =
                                                      cityList[index]['city'];
                                                  cityList = [];
                                                  setState(() {});
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: context.watch<AppService>().themeState.isDarkTheme == true
                                                            ? Color.fromARGB(
                                                                255, 51, 51, 51)
                                                            : Color.fromARGB(
                                                                255, 231, 231, 231)),
                                                    margin: EdgeInsets.only(
                                                        top: 3, bottom: 3),
                                                    padding: EdgeInsets.only(
                                                        top: 10, bottom: 10),
                                                    child: Text(
                                                        cityList[index]['city']['name'].toString() +
                                                            ', ' +
                                                            cityList[index]['city']['region'].toString())),
                                              ))),
                        ],
                      )
                    else if (_currentStep == _maxStep - 3)
                      Column(
                        children: [
                          Text(
                            Languages.of(context)!.when_job,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: whenNeedList.length,
                              itemBuilder: (ctx, index) => Column(
                                    children: [
                                      RadioListTile(
                                          title: Text(whenNeedList[index].toString() ==
                                                  'soon_as_possible'
                                              ? Languages.of(context)!.asap
                                              : whenNeedList[index].toString() ==
                                                      'flexible'
                                                  ? Languages.of(context)!
                                                      .flexibleTime
                                                  : whenNeedList[index].toString() ==
                                                          'in_two_month'
                                                      ? Languages.of(context)!
                                                          .inTwoMonth
                                                      : whenNeedList[index].toString() ==
                                                              'in_six_month'
                                                          ? Languages.of(context)!
                                                              .inSixMonth
                                                          : whenNeedList[index].toString() ==
                                                                  'only_price'
                                                              ? Languages.of(context)!
                                                                  .onlyPrice
                                                              : whenNeedList[index].toString() ==
                                                                      'specific_time'
                                                                  ? Languages.of(context)!
                                                                      .specificTime
                                                                  : ''),
                                          value: whenNeedList[index].toString(),
                                          groupValue: whenNeed,
                                          onChanged: (value) {
                                            setState(() {
                                              whenNeed = value.toString();
                                            });
                                          },
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 0),
                                          tileColor: context
                                                      .watch<AppService>()
                                                      .themeState
                                                      .isDarkTheme ==
                                                  false
                                              ? Color.fromRGBO(248, 248, 248, 1)
                                              : Colors.black87,
                                          activeColor: Color.fromRGBO(0, 194, 255, 1)),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      if (whenNeed == 'specific_time' &&
                                          whenNeedList[index] ==
                                              'specific_time')
                                        Container(
                                          color: context
                                                      .watch<AppService>()
                                                      .themeState
                                                      .isDarkTheme ==
                                                  false
                                              ? Color.fromRGBO(248, 248, 248, 1)
                                              : Colors.black87,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: InkWell(
                                                  onTap: () {
                                                    _selectDate(context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      enabled: false,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          _dateController,
                                                      onSaved: (String? val) {},
                                                      decoration: InputDecoration(
                                                          disabledBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: InkWell(
                                                  onTap: () {
                                                    _selectTime(context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      enabled: false,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          _timeController,
                                                      onSaved: (String? val) {},
                                                      decoration: InputDecoration(
                                                          disabledBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (whenNeed == 'specific_time' &&
                                          whenNeedList[index] ==
                                              'specific_time')
                                        SizedBox(
                                          height: 16,
                                        ),
                                    ],
                                  )),
                        ],
                      )
                    else if (_currentStep >= _questionStep &&
                        _currentStep < _maxStep - 6 &&
                        _questionStep != -1)
                      Column(
                        children: [
                          // Text(
                          //   Languages.of(context)!.answer_question,
                          //   textAlign: TextAlign.left,
                          //   style: TextStyle(
                          //     fontSize: 24,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
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
                                        if (_currentStep - index == 1)
                                          Text(
                                              selectedServiceData['questions']
                                                  [0][index]['question_text'],
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600)),
                                        if (_currentStep - index == 1)
                                          SizedBox(
                                            height: 20,
                                          ),
                                        if ((selectedServiceData['questions'][0]
                                                            [index]
                                                        ['question_type'] ==
                                                    'integer' &&
                                                _currentStep - index == 5) ||
                                            (selectedServiceData['questions'][0]
                                                            [index]
                                                        ['question_type'] ==
                                                    'number' &&
                                                _currentStep - index == 1))
                                          TextFormField(
                                              onChanged: (number) {
                                                setState(() {
                                                  questionBody[index]['value'] =
                                                      number.toString();
                                                });
                                              },
                                              initialValue: questionBody[index]
                                                  ['value'],
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
                                                fillColor: context
                                                            .watch<AppService>()
                                                            .themeState
                                                            .isDarkTheme ==
                                                        false
                                                    ? Color.fromRGBO(
                                                        248, 248, 248, 1)
                                                    : Colors.black87,
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
                                                'float' &&
                                            _currentStep - index == 1)
                                          TextFormField(
                                              onChanged: (number) {
                                                setState(() {
                                                  questionBody[index]['value'] =
                                                      number.toString();
                                                });
                                              },
                                              initialValue: questionBody[index]
                                                  ['value'],
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
                                                fillColor: context
                                                            .watch<AppService>()
                                                            .themeState
                                                            .isDarkTheme ==
                                                        false
                                                    ? Color.fromRGBO(
                                                        248, 248, 248, 1)
                                                    : Colors.black87,
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
                                                'checkbox' &&
                                            _currentStep - index == 1)
                                          Container(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
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
                                                'radio' &&
                                            selectedServiceData['questions'][0]
                                                            [index]
                                                        ['questions_options']
                                                    .length !=
                                                0 &&
                                            _currentStep - index == 1)
                                          Container(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
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
                                                'text' &&
                                            _currentStep - index == 1)
                                          TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                questionBody[index]['value'] =
                                                    value;
                                              });
                                            },
                                            initialValue: questionBody[index]
                                                ['value'],
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
                                              fillColor: context
                                                          .watch<AppService>()
                                                          .themeState
                                                          .isDarkTheme ==
                                                      false
                                                  ? Color.fromRGBO(
                                                      248, 248, 248, 1)
                                                  : Colors.black87,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        10),
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        19),
                                              ),
                                            ),
                                          )
                                        else if (selectedServiceData[
                                                        'questions'][0][index]
                                                    ['question_type'] ==
                                                'textarea' &&
                                            _currentStep - index == 1)
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
                                            initialValue: questionBody[index]
                                                ['value'],
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
                                              fillColor: context
                                                          .watch<AppService>()
                                                          .themeState
                                                          .isDarkTheme ==
                                                      false
                                                  ? Color.fromRGBO(
                                                      248, 248, 248, 1)
                                                  : Colors.black87,
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
                                                'unit' &&
                                            _currentStep - index == 1)
                                          TextFormField(
                                              onChanged: (number) {
                                                setState(() {
                                                  questionBody[index]['value'] =
                                                      number.toString();
                                                });
                                              },
                                              initialValue: questionBody[index]
                                                  ['value'],
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
                                                fillColor: context
                                                            .watch<AppService>()
                                                            .themeState
                                                            .isDarkTheme ==
                                                        false
                                                    ? Color.fromRGBO(
                                                        248, 248, 248, 1)
                                                    : Colors.black87,
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
                        ],
                      )
                    else if (_currentStep == _maxStep - 2)
                      Column(
                        children: [
                          Text(
                            Languages.of(context)!.enterPhone,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            Languages.of(context)!.phoneDescription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(139, 139, 151, 1),
                            ),
                          ),
                          SizedBox(
                            height: 52,
                          ),
                          Container(
                              width: 330,
                              child: Row(
                                children: [
                                  Container(
                                      width: 105,
                                      height: 50,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 13),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: context
                                                        .watch<AppService>()
                                                        .themeState
                                                        .isDarkTheme ==
                                                    false
                                                ? Color.fromRGBO(
                                                    217, 217, 217, 1)
                                                : Colors.transparent),
                                        color: context
                                                    .watch<AppService>()
                                                    .themeState
                                                    .isDarkTheme ==
                                                false
                                            ? Color.fromRGBO(248, 248, 248, 1)
                                            : Colors.black87,
                                      ),
                                      child: DropdownButton<String>(
                                        value: countryCode,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        elevation: 8,
                                        isExpanded: true,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                139, 139, 151, 1)),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.transparent,
                                        ),
                                        alignment: AlignmentDirectional.center,
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            countryCode = value!;
                                          });
                                        },
                                        items: dialCodeList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 13),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: context
                                                        .watch<AppService>()
                                                        .themeState
                                                        .isDarkTheme ==
                                                    false
                                                ? Color.fromRGBO(
                                                    217, 217, 217, 1)
                                                : Colors.transparent),
                                        color: context
                                                    .watch<AppService>()
                                                    .themeState
                                                    .isDarkTheme ==
                                                false
                                            ? Color.fromRGBO(248, 248, 248, 1)
                                            : Colors.black87,
                                      ),
                                      child: TextFormField(
                                        controller: phoneNumberInputCtrl,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              // selectedCityData = null;
                                            },
                                          );
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty == false) {}
                                          return null;
                                        },
                                        onFieldSubmitted: (value) {},
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
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
                                          fillColor: context
                                                      .watch<AppService>()
                                                      .themeState
                                                      .isDarkTheme ==
                                                  false
                                              ? Color.fromRGBO(248, 248, 248, 1)
                                              : Colors.black87,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                getProportionateScreenWidth(1),
                                            vertical:
                                                getProportionateScreenHeight(
                                                    19),
                                          ),
                                          hintText:
                                              Languages.of(context)!.enterPhone,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              width: 330,
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme ==
                                            false
                                        ? Color.fromRGBO(217, 217, 217, 1)
                                        : Colors.transparent),
                                color: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Color.fromRGBO(248, 248, 248, 1)
                                    : Colors.black87,
                              ),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                elevation: 8,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: Color.fromRGBO(139, 139, 151, 1)),
                                underline: Container(
                                  height: 0,
                                  color: Colors.transparent,
                                ),
                                alignment: AlignmentDirectional.center,
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: callList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: value == 'only_offers'
                                        ? Text(
                                            Languages.of(context)!.onlyOffers)
                                        : value == 'allow_contacts'
                                            ? Text(Languages.of(context)!
                                                .allow_contacts)
                                            : value == 'only_phone'
                                                ? Text(Languages.of(context)!
                                                    .only_phone)
                                                : Text(Languages.of(context)!
                                                    .only_whatsapp),
                                  );
                                }).toList(),
                              ))
                        ],
                      )
                    else if (_currentStep == _maxStep - 1)
                      Column(
                        children: [
                          Text(
                            Languages.of(context)!.planSelect,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          for (dynamic priority in appService
                              .selectedServiceItemData['priority_options'])
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selected_priority = priority['TYPE'];
                                  priority_coin = priority['CREDIT'];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme ==
                                            false
                                        ? Color.fromRGBO(243, 244, 246, 1)
                                        : Colors.black87,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Color.fromRGBO(
                                              137, 138, 143, 0.5),
                                          blurRadius: 2.0,
                                          offset: Offset(0, 2))
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                margin: EdgeInsets.only(bottom: 14),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 65,
                                          alignment: Alignment.bottomCenter,
                                          child: selected_priority !=
                                                  priority['TYPE']
                                              ? Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color.fromRGBO(
                                                              224,
                                                              224,
                                                              224,
                                                              1)),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                )
                                              : Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          79, 162, 219, 1),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            43, 43, 43, 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                  ),
                                                ),
                                        ),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                Languages.of(context)!
                                                    .type
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(
                                                        141, 142, 147, 1)),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                priority['NAME'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ])),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                Languages.of(context)!
                                                        .price
                                                        .toUpperCase() +
                                                    ' COINS',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(
                                                        141, 142, 147, 1)),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                priority['CREDIT'] == 0
                                                    ? Languages.of(context)!
                                                        .free
                                                        .toUpperCase()
                                                    : priority['CREDIT']
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ])),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Languages.of(context)!.ro == "România"
                                        ? Text(priority['DESCRIPTION_RO'])
                                        : Languages.of(context)!.sp == "Spagna"
                                            ? Text(priority['DESCRIPTION_IT'])
                                            : Text(priority['DESCRIPTION'])
                                  ],
                                ),
                              ),
                            ),
                        ],
                      )
                    else if (_currentStep == _maxStep)
                      Column(children: [
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/images/request_success.png',
                          fit: BoxFit.cover,
                          width: 90,
                          // height: double.infinity,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          Languages.of(context)!.receivedRequest +
                              ' "' +
                              appService.selectedServiceItemData['name'] +
                              '"',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(43, 44, 46, 1)
                                  : Colors.white70),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Text(
                          Languages.of(context)!.willNotify,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(43, 44, 46, 1)
                                  : Colors.white70),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ])
                  ],
                ))
        ])),
        bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
          if (_currentStep == _maxStep - 1)
            Text(
              Languages.of(context)!.acceptPolicy,
              textAlign: TextAlign.center,
            ),
          _currentStep == _maxStep - 5
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        width: 150,
                        child: GrayButton(
                            text: Languages.of(context)!.skip,
                            press: () {
                              setState(() {
                                _currentStep = _currentStep + 1;
                              });
                            })),
                    Container(
                        padding: EdgeInsets.all(10),
                        width: 150,
                        child: DefaultButton(
                            text: Languages.of(context)!.next_btn,
                            press: () {
                              if (imageList.length == 0 &&
                                  appService.selectedServiceItemData[
                                          'ask_photo'] ==
                                      true) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: Languages.of(context)!.alert_image,
                                  ),
                                );
                                return;
                              } else
                                setState(() {
                                  _currentStep = _currentStep + 1;
                                });
                            })),
                  ],
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  child: sendingRequest
                      ? Container(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()))
                      : DefaultButton(
                          text: _currentStep == _maxStep - 1
                              ? Languages.of(context)!.sendRequest
                              : _currentStep == _maxStep
                                  ? Languages.of(context)!.my_jobs
                                  : Languages.of(context)!.next_btn,
                          press: () async {
                            if (_currentStep == _maxStep - 6) {
                              if (descriptionInputCtrl.text == "") {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.info(
                                    message: Languages.of(context)!
                                        .alert_description,
                                  ),
                                );
                                return;
                              } else if (descriptionLength <
                                  validation['description_min']) {
                                return;
                              }
                            }
                            if (_currentStep == _maxStep - 5) {
                              if (imageList.length == 0 &&
                                  appService.selectedServiceItemData[
                                          'ask_photo'] ==
                                      true) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: Languages.of(context)!.alert_image,
                                  ),
                                );
                                return;
                              }
                            }
                            if (_currentStep == _maxStep - 4) {
                              if (selected_city.isEmpty) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message:
                                        Languages.of(context)!.alert_address,
                                  ),
                                );
                                return;
                              }
                            }
                            if (_currentStep == _maxStep - 3) {
                              if (whenNeed == "") {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message:
                                        Languages.of(context)!.alert_one_option,
                                  ),
                                );
                                return;
                              } else {
                                if (whenNeed == "specific_time") {
                                  if (_dateController.text == 'Select a date' ||
                                      _timeController.text == "Select a time") {
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                          message: Languages.of(context)!
                                              .alert_pick_date),
                                    );
                                    return;
                                  }
                                }
                              }
                            }
                            if (_currentStep >= _questionStep &&
                                _currentStep < _maxStep - 6 &&
                                _questionStep != -1) {
                              if (selectedServiceData['questions'] != null &&
                                  selectedServiceData['questions'][0].length !=
                                      0) {
                                if (selectedServiceData['questions'][0]
                                        [_currentStep - 1]['question_type'] ==
                                    'checkbox') {
                                  if (questionBody[_currentStep - 1]['value']
                                          .length ==
                                      0) {
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                        message: Languages.of(context)!
                                                .alert_answer +
                                            '"' +
                                            selectedServiceData['questions'][0]
                                                    [_currentStep - 1]
                                                ['question_text'] +
                                            '"',
                                      ),
                                    );
                                    return;
                                  }
                                } else {
                                  if (questionBody[_currentStep - 1]['value'] ==
                                      "") {
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                          message: Languages.of(context)!
                                                  .alert_answer +
                                              '"' +
                                              selectedServiceData['questions']
                                                      [0][_currentStep - 1]
                                                  ['question_text'] +
                                              '"'),
                                    );
                                    return;
                                  }
                                  ;
                                }
                              }
                            }

                            if (_currentStep == _maxStep - 2) {
                              if (phoneNumberInputCtrl.text.isEmpty) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: Languages.of(context)!.alert_phone,
                                  ),
                                );
                                return;
                              }
                            }

                            if (_currentStep == _maxStep - 1) {
                              String phoneNumber = countryCode
                                      .substring(4, countryCode.length)
                                      .toString() +
                                  phoneNumberInputCtrl.text.toString();
                              String whenNeedDate =
                                  DateTime.now().toIso8601String();
                              if (whenNeed == "specific_time") {
                                whenNeedDate = _dateController.text +
                                    'T' +
                                    _timeController.text;
                              }

                              String phoneOption = dropdownValue;
                              if (appService.user['credits'] < priority_coin) {
                                if (Platform.isIOS) {
                                  GoRouter.of(context).pushNamed(
                                      APP_PAGE.buyCreditsApple.toName);
                                } else {
                                  GoRouter.of(context)
                                      .pushNamed(APP_PAGE.buyCredits.toName);
                                }
                                return;
                              }
                              setState(
                                () {
                                  sendingRequest = true;
                                },
                              );
                              if (city != null) {
                                dynamic response = await appService
                                    .createNewRequest(
                                        address: selected_city,
                                        city_id: city['id'],
                                        full_name: appService
                                                    .user['full_name'] ==
                                                null
                                            ? Languages.of(context)!.unnamed
                                            : appService.user['full_name'],
                                        phone: phoneNumber,
                                        files: imageList.length == 0
                                            ? ''
                                            : jsonEncode(imageList),
                                        description: descriptionInputCtrl.text,
                                        when_need: whenNeed,
                                        when_need_date: whenNeedDate,
                                        priority: selected_priority,
                                        questions: questionBody.length == 0
                                            ? ""
                                            : jsonEncode(questionBody),
                                        service_id: appService
                                            .selectedServiceItemData['id'],
                                        latitude: latitude,
                                        phone_options: phoneOption,
                                        longitude: longitude);
                                setState(
                                  () {
                                    sendingRequest = false;
                                  },
                                );
                                if (response is String || response == null) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: response,
                                    ),
                                  );
                                  return;
                                } else {}
                              } else {
                                dynamic response = await appService
                                    .createNewRequest(
                                        address: selected_city,
                                        city_id: null,
                                        full_name: appService
                                                    .user['full_name'] ==
                                                null
                                            ? Languages.of(context)!.unnamed
                                            : appService.user['full_name'],
                                        phone: phoneNumber,
                                        files: imageList.length == 0
                                            ? ''
                                            : jsonEncode(imageList),
                                        description: descriptionInputCtrl.text,
                                        when_need: whenNeed,
                                        when_need_date: whenNeedDate,
                                        priority: selected_priority,
                                        questions: questionBody.length == 0
                                            ? ""
                                            : jsonEncode(questionBody),
                                        service_id: appService
                                            .selectedServiceItemData['id'],
                                        latitude: latitude,
                                        phone_options: phoneOption,
                                        longitude: longitude);
                                setState(
                                  () {
                                    sendingRequest = false;
                                  },
                                );
                                if (response is String || response == null) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: response,
                                    ),
                                  );
                                  return;
                                } else {}
                              }
                            }

                            if (_currentStep == _maxStep) {
                              GoRouter.of(context)
                                  .pushNamed(APP_PAGE.myJobs.toName);
                            }
                            if (_currentStep < _maxStep)
                              setState(() {
                                _currentStep = _currentStep + 1;
                              });
                          })),
        ]));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.grey,
                ),
                onPressed: (() {
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              Languages.of(context)!.areyousure,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(43, 44, 46, 1)),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Text(
                              Languages.of(context)!.alert_close_description,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(43, 44, 46, 1)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(248, 248, 248, 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    Languages.of(context)!.go_on,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(43, 44, 46, 1)),
                                  ),
                                )),
                            SizedBox(
                              height: 11,
                            ),
                            InkWell(
                                onTap: () {
                                  GoRouter.of(context).pop();
                                  GoRouter.of(context)
                                      .pushNamed(APP_PAGE.home.toName);
                                },
                                child: Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(232, 104, 111, 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    Languages.of(context)!.quit,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(43, 44, 46, 1)),
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                  );
                })),
          )
        ],
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.grey,
            ),
            onPressed: (() => {
                  if (_currentStep == 1)
                    GoRouter.of(context).pop()
                  else
                    setState(() {
                      _currentStep = _currentStep - 1;
                    })
                })),
        title: Text(
          _currentStep == _maxStep - 1
              ? Languages.of(context)!.requestPriority
              : _currentStep == _maxStep
                  ? Languages.of(context)!.Congratulation
                  : appService.selectedServiceItemData['name'],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ));
  }
}

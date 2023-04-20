import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:go_router/go_router.dart';

class Body extends StatefulWidget {
  const Body(
      // key? key,
      );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isSending = false;
  bool firstSubmit = false;
  DateTime selectedDate = DateTime.now();
  String description = '';
  String price = '';
  String deadline = '';
  String phone = '';
  List<String> priceTypeList = <String>[
    'USD',
    'EURO',
    'RON',
  ];
  String selectedPriceType = "USD";
  static const List<String> offerTypeList = <String>[
    "day",
    "hour",
    "total",
  ];
  List<String> offerTypeTranslatedList = <String>[];
  String offerTypeTranslatedKey = '';
  String offer_type = offerTypeList.first;

  TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    initData();
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    priceController.dispose();
    deadlineController.dispose();
    descriptionController.dispose();
    super.dispose();
    //...
  }

  void initData() {
    if (!mounted) return;
    setState(() {
      description = _appService.selectedOfferToUpdate['description'];
      descriptionController.text = description;
      price = _appService.selectedOfferToUpdate['price'].toString();
      priceController.text = price;
      deadline = _appService.selectedOfferToUpdate['dead_line'] == null
          ? ""
          : _appService.selectedOfferToUpdate['dead_line'].toString();
      deadlineController.text = deadline;

      selectedPriceType =
          _appService.selectedOfferToUpdate['currency_type'] == null
              ? "USD"
              : _appService.selectedOfferToUpdate['currency_type'];
      offer_type = _appService.selectedOfferToUpdate['offer_type'] == null
          ? 'day'
          : _appService.selectedOfferToUpdate['offer_type'];

      final formatter = DateFormat('EEE, d MMM yyyy HH:mm:ss');
      if (_appService.selectedOfferToUpdate['available_from'] != null) {
        final dateTime = formatter
            .parse(_appService.selectedOfferToUpdate['available_from']);
        _dateController.text = DateFormat('yyyy-MM-dd').format(dateTime);
      } else {
        _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      }
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    offerTypeTranslatedList = <String>[];
    offerTypeTranslatedKey = Languages.of(context)!.day.toUpperCase();
    offerTypeTranslatedList.add(Languages.of(context)!.day.toUpperCase());
    offerTypeTranslatedList.add(Languages.of(context)!.hour.toUpperCase());
    offerTypeTranslatedList.add(Languages.of(context)!.total.toUpperCase());

    Locale myLocale = Localizations.localeOf(context);
    return Form(
      key: _formKey,
      child: Column(children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Color.fromRGBO(137, 138, 143, 0.5)
                        : Color.fromRGBO(153, 153, 153, 0.5),
              ),
              color: context.watch<AppService>().themeState.isDarkTheme == false
                  ? Color.fromRGBO(249, 249, 255, 1)
                  : Colors.black87,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _appService.selectedJobData['service']['name'] +
                          (_appService.selectedJobData['city'] == null
                              ? ''
                              : ', ' +
                                  _appService.selectedJobData['city']['name']),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Color.fromRGBO(57, 58, 60, 1)
                              : Colors.white70),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat(
                                      'dd.MM.yyyy',
                                      myLocale.countryCode
                                                  .toString()
                                                  .toLowerCase() ==
                                              "us"
                                          ? "en"
                                          : myLocale.countryCode.toString())
                                  .format(DateTime.parse(
                                _appService.selectedJobData['updated_on'],
                              )) +
                              ',  ' +
                              DateFormat.jm(myLocale.countryCode
                                              .toString()
                                              .toLowerCase() ==
                                          "us"
                                      ? "en"
                                      : myLocale.countryCode.toString())
                                  .format(DateTime.parse(
                                _appService.selectedJobData['updated_on'],
                              )),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(79, 162, 219, 1)),
                        ),
                        // Text(
                        //   Languages.of(context)!.totalProposal +
                        //       ' : ' +
                        //       '12',
                        //   style: TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w700,
                        //       color: Color.fromRGBO(79, 162, 219, 1)),
                        // )
                      ],
                    )
                  ],
                )),
                Text(
                  '#' + _appService.selectedJobData['id'].toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            )),
        Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  controller: descriptionController,
                  onChanged: (value) {
                    if (firstSubmit) _formKey.currentState!.validate();
                    setState(() {
                      description = value;
                    });
                  },
                  validator: (description) {
                    if (description!.isEmpty) {
                      return Languages.of(context)!.kDescriptionNullError;
                    }
                    return null;
                  },
                  maxLines: 5,
                  maxLength: 2000,
                  decoration: InputDecoration(
                    labelText: Languages.of(context)!.description,
                    hintText: Languages.of(context)!.offerDescriptionHint,
                    suffixIcon:
                        // this.name.isEmpty
                        //     ? CustomSuffixIcon(iconPath: "assets/icons/User.svg")
                        Icon(Icons.check),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 3,
                        child: TextFormField(
                          controller: priceController,
                          onChanged: (value) {
                            if (firstSubmit) _formKey.currentState!.validate();
                            setState(() {
                              price = value;
                            });
                          },
                          validator: (price) {
                            if (price!.isEmpty) {
                              return Languages.of(context)!.kPriceNullError;
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: Languages.of(context)!.price,
                            hintText: '0.00',
                            suffixIcon:
                                // this.name.isEmpty
                                //     ? CustomSuffixIcon(iconPath: "assets/icons/User.svg")
                                Icon(Icons.check),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(255, 121, 121, 121)),
                          )),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                            value: selectedPriceType,
                            elevation: 16,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                selectedPriceType = value!;
                              });
                            },
                            items: priceTypeList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                        )),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onTap: () {
                    _selectDate(context);
                  },
                  readOnly: true,
                  controller: _dateController,
                  onSaved: (newName) {},
                  decoration: InputDecoration(
                    labelText: 'Available From',
                    hintText: 'in 7 days',
                    suffixIcon:
                        // this.name.isEmpty
                        //     ? CustomSuffixIcon(iconPath: "assets/icons/User.svg")
                        Icon(Icons.check),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: deadlineController,
                  onChanged: (value) {
                    if (firstSubmit) _formKey.currentState!.validate();
                    setState(() {
                      deadline = value;
                    });
                  },
                  validator: (deadline) {
                    if (deadline!.isEmpty) {
                      return Languages.of(context)!.kDeadLineNullError;
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                    labelText: Languages.of(context)!.deadline,
                    hintText: Languages.of(context)!.deadLineHint,
                    suffixIcon:
                        // this.name.isEmpty
                        //     ? CustomSuffixIcon(iconPath: "assets/icons/User.svg")
                        Icon(Icons.check),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    Languages.of(context)!.offerType,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
                DropdownButton<String>(
                  value: offerTypeTranslatedKey,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 8,
                  isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      offerTypeTranslatedKey = value!;
                      for (int i = 0; i < offerTypeTranslatedList.length; i++) {
                        if (offerTypeTranslatedKey ==
                            offerTypeTranslatedList[i])
                          offer_type = offerTypeList[i];
                      }
                    });
                  },
                  items: offerTypeTranslatedList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // TextFormField(
                //   onChanged: (value) {
                //     if (firstSubmit) _formKey.currentState!.validate();
                //     setState(() {
                //       phone = value;
                //     });
                //   },
                //   validator: (phone) {
                //     if (phone!.isEmpty) {
                //       return kPhoneNumberNullError;
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     labelText: Languages.of(context)!.phone,
                //     hintText: '465789234',
                //     suffixIcon:
                //         // this.name.isEmpty
                //         //     ? CustomSuffixIcon(iconPath: "assets/icons/User.svg")
                //         Icon(Icons.check),
                //   ),
                //   keyboardType: TextInputType.phone,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  height: 30,
                ),
                isSending
                    ? CircularProgressIndicator()
                    : DefaultButton(
                        text: Languages.of(context)!.update_offer,
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              isSending = true;
                            });

                            dynamic response =
                                await _appService.uddateOfferByID(
                                    price: int.parse(price),
                                    description: description,
                                    deadline: int.parse(deadline),
                                    available_from: _dateController.text,
                                    offer_type: offer_type,
                                    currency_type: selectedPriceType,
                                    offerID: _appService
                                        .selectedOfferToUpdate['id']);
                            setState(() {
                              isSending = false;
                            });

                            if (response is String || response == null) {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: response,
                                ),
                              );
                            } else {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.success(
                                  message: Languages.of(context)!.sentOffer,
                                ),
                              );
                              GoRouter.of(context)
                                  .pushNamed(APP_PAGE.myOffers.toName);
                            }
                          }
                          firstSubmit = true;
                        })
              ],
            ))
      ]),
    );
  }
}

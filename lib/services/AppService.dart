import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';
import 'chatApi.dart';
import 'package:localservice/models/user_info.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum enumPaymentMethod { apple, bitcoin, paypal, stripe, google_pay, bank }

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  bool _loginState = false;
  bool _initialized = false;
  bool _hasRoom = false;
  bool _onboarding = false;
  bool _isFav = false;
  bool _isFromBrowser = false;
  dynamic _homePageData = null;
  dynamic _myChatRooms = null;
  dynamic _categoryDataList = null;
  dynamic _countryList = null;
  late ChangeThemeState _themeState;
  String _apiKey = '';
  String _verifyPhoneNumber = '';
  String _verifyCountryCode = '';
  dynamic _chatSocket = null;
  dynamic _user = null;
  String _inviteCode = '';
  String _deeplinkRequestID = '';
  String _keywords = "";
  dynamic _selectedChatRoomData = null;
  dynamic _selectedChatUser = null;
  dynamic _selectedChatProduct = null;
  bool _receivedNewNotification = false;
  BuildContext? _contextData = null;
  bool _countryRegistered = false;
  int _productIdAdding = 0;
  int _productId4Review = 0;
  int _sellerID = 0;
  dynamic _selectedUserProfileData = null;
  dynamic _selectedUserReviewed = null;
  int _selectedRequestIDReviewed = -1;
  int _selectedOfferIDfromNotification = -1;
  String _selecteduserProfilePhoneNumber = '';
  int _selectedChatRoomID = -1;
  int _selectedRequestIDfromNotfication = -1;
  bool _fromPushNotification = false;

  /** service data */
  dynamic _selectedServices = null;
  dynamic _selectedSubServiceList = null;
  dynamic _selectedRequestData = null;
  dynamic _selectedJobData = null;
  dynamic _selectedServiceItemData = null;
  dynamic _selectedCities = null;
  dynamic _selectedCredit = null;
  dynamic _selectedServiceToAdd = null;
  dynamic _selectedOfferToUpdate = null;
  bool _browserRefreshed = true;

  /** payment data */
  enumPaymentMethod? _currentPaymentMethod = enumPaymentMethod.bitcoin;
  dynamic _paymentMethodList = null;

  AppService(this.sharedPreferences);
  bool get loginState => _loginState;
  bool get countryRegistered => _countryRegistered;
  bool get initialized => _initialized;
  bool get hasRoom => _hasRoom;
  bool get onboarding => _onboarding;
  bool get isFav => _isFav;
  dynamic get chatSocket => _chatSocket;
  bool get isFromBrowser => _isFromBrowser;
  String get keywords => _keywords;
  bool get fromPushNotification => _fromPushNotification;
  dynamic get categoryDataList => _categoryDataList;
  dynamic get homePageData => _homePageData;
  dynamic get myChatRooms => _myChatRooms;
  dynamic get selectedChatRoomData => _selectedChatRoomData;
  dynamic get selectedChatUser => _selectedChatUser;
  bool get receivedNewNotification => _receivedNewNotification;
  int get productIdAdding => _productIdAdding;
  int get productId4Review => _productId4Review;
  dynamic get selectedChatProduct => _selectedChatProduct;
  BuildContext get contextData => _contextData!;
  ChangeThemeState get themeState => _themeState;
  int get sellerID => _sellerID;
  dynamic get user => _user;
  String get apiKey => _apiKey;
  dynamic get selectedServices => _selectedServices;
  dynamic get selectedSubServiceList => _selectedSubServiceList;
  dynamic get selectedRequestData => _selectedRequestData;
  dynamic get selectedJobData => _selectedJobData;
  dynamic get selectedServiceItemData => _selectedServiceItemData;
  dynamic get selectedCities => _selectedCities;
  dynamic get selectedCredit => _selectedCredit;
  dynamic get countryList => _countryList;
  enumPaymentMethod? get currentPaymentMethod => _currentPaymentMethod;
  dynamic get paymentMethodList => _paymentMethodList;
  dynamic get selectedServiceToAdd => _selectedServiceToAdd;
  dynamic get selectedOfferToUpdate => _selectedOfferToUpdate;
  dynamic get selectedUserProfileData => _selectedUserProfileData;
  String get selecteduserProfilePhoneNumber => _selecteduserProfilePhoneNumber;
  dynamic get selectedUserReviewed => _selectedUserReviewed;
  int get selectedRequestIDReviewed => _selectedRequestIDReviewed;
  int get selectedOfferIDfromNotification => _selectedOfferIDfromNotification;
  int get selectedChatRoomID => _selectedChatRoomID;
  int get selectedRequestIDfromNotfication => _selectedRequestIDfromNotfication;
  String get deeplinkRequestID => _deeplinkRequestID;
  bool get browserRefreshed => _browserRefreshed;
  String get inviteCode => _inviteCode;
  set currentPaymentMethod(enumPaymentMethod? data) {
    _currentPaymentMethod = data;
  }

  set browserRefreshed(bool flag) {
    _browserRefreshed = flag;
  }

  set selectedChatRoomID(int ID) {
    _selectedChatRoomID = ID;
  }

  set fromPushNotification(bool flag) {
    _fromPushNotification = flag;
  }

  set chatSocket(dynamic socket) {
    _chatSocket = socket;
  }

  set inviteCode(String code) {
    _inviteCode = code;
  }

  set themeState(ChangeThemeState themeState) {
    _themeState = themeState;
  }

  set deeplinkRequestID(String id) {
    _deeplinkRequestID = id;
  }

  set selectedUserReviewed(dynamic data) {
    _selectedUserReviewed = data;
  }

  set selectedRequestIDfromNotfication(int id) {
    _selectedRequestIDfromNotfication = id;
  }

  set selecteduserProfilePhoneNumber(String phoneNumber) {
    _selecteduserProfilePhoneNumber = phoneNumber;
  }

  set selectedRequestIDReviewed(int ID) {
    _selectedRequestIDReviewed = ID;
  }

  set receivedNewNotification(bool flag) {
    _receivedNewNotification = flag;
  }

  set selectedOfferIDfromNotification(int ID) {
    _selectedOfferIDfromNotification = ID;
  }

  set selectedUserProfileData(dynamic data) {
    _selectedUserProfileData = data;
  }

  set selectedOfferToUpdate(dynamic data) {
    _selectedOfferToUpdate = data;
  }

  set selectedServiceToAdd(dynamic data) {
    _selectedServiceToAdd = data;
  }

  set countryRegistered(bool data) {
    _countryRegistered = data;
  }

  set selectedChatUser(dynamic user) {
    _selectedChatUser = user;
  }

  set paymentMethodList(dynamic data) {
    _paymentMethodList = data;
  }

  set loginState(bool state) {
    _loginState = state;
    notifyListeners();
  }

  set countryList(dynamic data) {
    _countryList = data;
  }

  set user(dynamic user) {
    _user = user;
  }

  set myChatRooms(dynamic chatRooms) {
    _myChatRooms = chatRooms;
  }

  set contextData(BuildContext context) {
    _contextData = context;
  }

  set selectedChatRoomData(dynamic data) {
    _selectedChatRoomData = data;
  }

  set selectedChatProduct(dynamic selectedChatProduct) {
    _selectedChatProduct = selectedChatProduct;
  }

  set productIdAdding(int id) {
    _productIdAdding = id;
  }

  set productId4Review(int id) {
    _productId4Review = id;
  }

  set sellerID(int id) {
    _sellerID = id;
  }

  set categoryDataList(dynamic categoryDataList) {
    _categoryDataList = categoryDataList;
  }

  set setKeyworkds(String keywords) {
    _keywords = keywords;
  }

  set apiKey(dynamic key) {
    _apiKey = key;
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  set hasRoom(bool value) {
    _hasRoom = value;
  }

  set onboarding(bool value) {
    _onboarding = value;
    notifyListeners();
  }

  set isFav(bool value) {
    _isFav = value;
  }

  set isFromBrowser(bool value) {
    _isFromBrowser = value;
  }

  set selectedServices(dynamic data) {
    _selectedServices = data;
  }

  set selectedSubServiceList(dynamic data) {
    _selectedSubServiceList = data;
  }

  set selectedRequestData(dynamic data) {
    _selectedRequestData = data;
  }

  set selectedJobData(dynamic data) {
    _selectedJobData = data;
  }

  set selectedServiceItemData(dynamic data) {
    _selectedServiceItemData = data;
  }

  set selectedCities(dynamic data) {
    _selectedCities = data;
  }

  set selectedCredit(dynamic data) {
    _selectedCredit = data;
  }

  String invalidToken = "token is invalid";
  String missingToken = "a valid token is missing";
  /********** login user code *********/
  Future<dynamic> loginUser(
      {required String email,
      required String password,
      String? otp,
      String? firebase_token,
      String? device_id}) async {
    try {
      Response response = await Api().dio.post('auth/login',
          data: {
            'email': email,
            'password': password,
            'otp': otp,
            "device_id": device_id,
            "firebase_token": firebase_token
          },
          options: Options(
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
              'accept': 'application/json'
            },
          ));
      await initUser(response);
      return response;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> sendFileToUserInChat({
    required String file_type,
    required File file,
  }) async {
    try {
      Response? response;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });
      response =
          await ChatApi().dio.post('upload?file_type=' + file_type.toString(),
              data: formData,
              options: Options(
                headers: {
                  'content-type': 'multipart/form-data',
                  'accept': 'application/json'
                },
              ));

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /********** create user code *********/
  Future<dynamic> createUser({
    required String email,
    required String password,
    required String name,
    required String latitude,
    required String userType,
    required String longitude,
    String? otp,
    String? firebase_token,
    String? device_id,
    String? inviteCode,
  }) async {
    try {
      Response response = await Api().dio.post('auth/register',
          data: {
            'email': email,
            'full_name': name,
            'password': password,
            'invite_code': inviteCode,
            'latitude': latitude,
            'longitude': longitude,
            'user_type': userType,
            'otp': otp,
            "device_id": device_id,
            "firebase_token": firebase_token
          },
          options: Options(
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
              'accept': 'application/json'
            },
          ));
      await initUser(response);
      return response;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  /********** forgot password *********/
  Future<dynamic> forgotPassword({required String email}) async {
    try {
      Response response =
          await Api().dio.post('auth/forgot-password', data: {'email': email});

      await sharedPreferences.setString(
          'resetcode', response.data['resetcode']);
      await sharedPreferences.setString('resetpasswordemail', email);
      return response;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  /**************reset password ************/
  Future<dynamic> resetPassword({
    required String email,
    required String email_code,
    required String new_password,
  }) async {
    try {
      Response response = await Api().dio.post('auth/reset-password', data: {
        'email': email,
        'email-code': email_code,
        'newpassword': new_password
      });
      return response;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  /*********************change password *****************/
  Future<dynamic> changePassword({
    required String password,
    required String new_password,
  }) async {
    try {
      Response response = await Api().dio.post('auth/change-password',
          data: {'password': password, 'new_password': new_password});
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  Future<void> saveUserData() async {
    await sharedPreferences.setString('userData', jsonEncode(_user));
  }

  /******************update user *************/
  Future<dynamic> updateUser({required UserInfo user}) async {
    try {
      String fileName = user.avatar!.path.split('/home').last;
      FormData formData = FormData.fromMap({
        "avatar":
            await MultipartFile.fromFile(user.avatar!.path, filename: fileName),
        "email": user.email,
        "tz": user.tz,
        "full_name": user.fullName
      });
      Response response = await Api().dio.put('auth/me',
          data: formData,
          options: Options(
            headers: {
              'content-type': 'multipart/form-data',
              'accept': 'application/json'
            },
          ));
      _user = response.data;
      await sharedPreferences.setString('userData', jsonEncode(_user));
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************get user profile *************/
  Future<dynamic> getUserProfile({required int userID}) async {
    try {
      Response response = await Api().dio.get(
            'user/profile/' + userID.toString() + '?with_reviews=true',
          );
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/******************award user to request id *************/
  Future<dynamic> awardUserToRequestID(
      {required int userID, required int requestID}) async {
    try {
      Response response = await Api().dio.post(
            'request/' + requestID.toString() + '/award/' + userID.toString(),
          );
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************update profile *************/
  Future<dynamic> updateProfile(
      {String? full_name,
      String? email,
      String? phone_number,
      String? country_code,
      String? address}) async {
    try {
      Response response =
          await Api().dio.post('user/update-profile', queryParameters: {
        "full_name": full_name,
        'email': email,
        'phone_number': phone_number,
        "country_code": country_code,
        "address": address
      });
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************change user type *************/
  Future<dynamic> changeUserType({
    required String type,
  }) async {
    try {
      Response response =
          await Api().dio.post('user/change-user-type?user_type=$type');
      _user['user_type'] = type;
      await sharedPreferences.setString('userData', jsonEncode(_user));

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************update user name *************/
  Future<dynamic> updateUserName({required UserInfo user}) async {
    try {
      FormData formData = FormData.fromMap(
          {"email": user.email, "tz": user.tz, "full_name": user.fullName});
      Response response = await Api().dio.put('auth/me',
          data: formData,
          options: Options(
            headers: {
              'content-type': 'multipart/form-data',
              'accept': 'application/json'
            },
          ));
      _user = response.data;
      await sharedPreferences.setString('userData', jsonEncode(_user));
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************get user info ************************/
  Future<dynamic> getUserInfo() async {
    try {
      Response response = await Api().dio.get('auth/me');
      _user = response.data['data'];
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************setup TwoFa code *********/
  Future<dynamic> setUpTwoFa({required String otp}) async {
    try {
      Response response = await Api().dio.put('auth/twofa', data: {'otp': otp});
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************getTwo Fa code *********/
  Future<dynamic> getTwoFa({required String otp}) async {
    try {
      Response response = await Api().dio.get('auth/twofa');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************delete TwoFa ***************/
  Future<dynamic> deleteTwoFa({required String otp}) async {
    try {
      Response response = await Api().dio.delete('auth/twofa');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************logout code **************/
  logOut() async {
    try {
      Response response = await Api().dio.get('auth/logout');
      removeAllData();
      return response;
    } on Exception catch (e) {
      // removeAllData();
      return e.toString();
    }
  }

  /*******************close account **************/
  closeAccount({required String password}) async {
    try {
      Response response = await Api().dio.delete('auth/me',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'password': password});

      removeAllData();
      return response;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  /**************get category ******************/
  Future<dynamic> getCategory() async {
    try {
      Response response = await Api().dio.get('categories');
      await sharedPreferences.setString(
          'category_list', json.encode(response.data['data']));
      _categoryDataList = response.data['data'];
      return response;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  /**************get product by ID ******************/
  Future<dynamic> getProductByID({required int productID}) async {
    try {
      Response response = await Api().dio.get('products/$productID');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /**************get product files by ID ******************/
  Future<dynamic> getProductFIlesByID({required int productID}) async {
    try {
      Response response = await Api().dio.get('products/$productID/files');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /************add product as seen **********/
  Future<dynamic> addProductAsSeen({required int productID}) async {
    try {
      Response response = await Api().dio.get('products/$productID/seen');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /************** set language ***************/
  Future<dynamic> setLanguage({required String langCode}) async {
    try {
      Response response =
          await Api().dio.put('auth/language', data: {'language': langCode});
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*****************get homepage data list ****************/
  Future<dynamic> getHomePageDataList({
    int? offset = 0,
    int? limit = 100,
    String? searchKey,
  }) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }
    if (searchKey != null) {
      filter += '&search=$searchKey';
    }
    try {
      Response response = await Api().dio.get('home/services' + filter);

      await sharedPreferences.setString(
          'homepage_data', json.encode(response.data));
      _homePageData = response.data;
      if (response == invalidToken || response == missingToken)
        emptyLocalStorage();
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken) {
        emptyLocalStorage();
      }
      return e.toString();
    }
  }

  /*****************get all country list ****************/
  Future<dynamic> getCountryList() async {
    try {
      Response response = await Api().dio.get('home/countries');

      if (response == invalidToken || response == missingToken)
        emptyLocalStorage();

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken) {
        emptyLocalStorage();
      }
      return e.toString();
    }
  }

  /*****************get all country list ****************/
  Future<dynamic> getWhenNeedConfig() async {
    try {
      Response response = await Api().dio.get('/configs');

      if (response == invalidToken || response == missingToken)
        emptyLocalStorage();

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken) {
        emptyLocalStorage();
      }
      return e.toString();
    }
  }

  /**
   * @user api part
   */

  /*******************get my services ******************/
  Future<dynamic> getMyServices({int? offset, int? limit = 25}) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }

    try {
      Response response = await Api().dio.get('user/work/my-sevices' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/******************* add my service ************************/
  Future<dynamic> addMyService1(
      {required int city_id, required int service_id}) async {
    FormData formData =
        FormData.fromMap({"city_id": city_id, "service_id": service_id});
    try {
      Response response = await Api().dio.post('user/my-servicess',
          data: formData,
          options: Options(
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
              'accept': 'application/json'
            },
          ));
      if (response.data['success'] == true)
        _selectedServices.add(selectedServiceToAdd);

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************get my services ******************/
  Future<dynamic> getMyServices1({int? offset, int? limit = 25}) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }

    try {
      Response response = await Api().dio.get('user/my-servicess' + filter);
      _selectedServices = [];
      for (int i = 0; i < response.data['data'].length; i++)
        _selectedServices.add({
          "id": response.data['data'][i]['service']['id'],
          "name": response.data['data'][i]['service']['name'],
          "selected": true,
          "user_service_id": response.data['data'][i]['id']
        });
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************get my services ******************/
  Future<dynamic> deleteMyServiceID({required int id}) async {
    try {
      Response response =
          await Api().dio.delete('user/my-services/' + id.toString());
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************get my offers ******************/
  Future<dynamic> getMyOffers({
    int? offset,
    int? limit = 25,
  }) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }

    try {
      Response response = await Api().dio.get('user/work/my-offers' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************get my offers ******************/
  Future<dynamic> getMyUnlockedRequests({
    int? offset,
    int? limit = 25,
  }) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }

    try {
      Response response =
          await Api().dio.get('user/requests-unlocked' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************get my Cities ******************/
  Future<dynamic> getMyCities({int? offset, int? limit = 25}) async {
    // String filter = '?limit=$limit';
    // if (offset != null) {
    //   filter += '&offset=$offset';
    // }

    try {
      Response response = await Api().dio.get('user/work/my-cities');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************validate phone number ******************/
  Future<dynamic> validatePhoneNumber(
      {required String country_code, required String phone_number}) async {
    try {
      Response response = await Api()
          .dio
          .post('user/work/validate-phone-number/start', queryParameters: {
        'country_code': country_code,
        'phone_number': phone_number
      });
      _verifyPhoneNumber = phone_number;
      _verifyCountryCode = country_code;
      return response;
    } on Exception catch (e) {
      _verifyPhoneNumber = '';
      _verifyCountryCode = '';
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************confirm phone number ******************/
  Future<dynamic> confirmPhoneSmsCode({required String sms_code}) async {
    try {
      Response response = await Api()
          .dio
          .post('user/work/validate-phone-number/confirm', queryParameters: {
        'country_code': _verifyCountryCode,
        'phone_number': _verifyPhoneNumber,
        'sms_code': sms_code
      });
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /**
   * @chat api part
   */

  /*******************get my chat rooms ******************/
  Future<dynamic> getMyChatRooms(
      {int? limit = 25, int? offset, bool? is_arhived}) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }
    try {
      String user_type = "hire";
      if (_user['is_worker'] == true && _user['user_type'] == "work")
        user_type = "work";
      Response response =
          await Api().dio.get('chat/my-rooms/' + user_type + filter);
      _myChatRooms = response.data['data'].reversed.toList();
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************get my chat rooms ******************/
  Future<dynamic> getChatRoomByID({required int id}) async {
    try {
      Response response = await Api().dio.get('chat/' + id.toString());
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************create chat room****************/
  Future<dynamic> createChatRoom(
      {required int offerID, String? message}) async {
    try {
      // message = '?message=' + message!;

      Response response = await Api().dio.post('chat/new/' + offerID.toString(),
          queryParameters: {'message': message});

      // _selectedChatRoomData = response.data["data"];
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /**************archiveChatRoomBy ID **********/
  Future<dynamic> archiveChatroomByID({required int roomID}) async {
    try {
      Response response = await Api().dio.put('chat/archive/$roomID');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************delete chat room by ID *********/
  Future<dynamic> deleteChatroomByID({required int roomID}) async {
    try {
      Response response = await Api().dio.delete('chat/archive/$roomID');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /***************send message by ID **********************/
  Future<dynamic> sendMessageByID(
      {required int roomID, String? message}) async {
    try {
      Response response =
          await Api().dio.post('chat/message/$roomID?message=$message');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /****************create new room by ID ************/
  Future<dynamic> createNewRoomByID(
      {required int productID, String? message}) async {
    try {
      Response response =
          await Api().dio.post('chat/new/$productID?message=$message');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /**
   * @favorite api
   */
  /*******************get all favorite workers ******************/
  Future<dynamic> getAllMyFavoriteWorkers() async {
    try {
      Response response = await Api().dio.get('favorite/');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************delete favorite worker by id ******************/
  Future<dynamic> deleteFavoriteWorkerByID({required int user_id}) async {
    try {
      Response response =
          await Api().dio.delete('favorite/' + user_id.toString());
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /*******************add favorite worker by id ******************/
  Future<dynamic> addFavoriteWorkerByID({required int user_id}) async {
    try {
      Response response =
          await Api().dio.post('favorite/' + user_id.toString());
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  removeAllData() async {
    _user = null;
    _apiKey = "";
    _loginState = false;
    _selectedChatRoomData = null;
    _homePageData = null;
    _myChatRooms = null;
    _categoryDataList = null;
    _productId4Review = 0;
    _productId4Review = 0;
    _sellerID = 0;
    String countryCode = await sharedPreferences.getString('country_id') ?? "";
    String language =
        await sharedPreferences.getString('SelectedLanguageCode') ?? "";

    int option = sharedPreferences.getInt('theme_option') ?? 0;
    await sharedPreferences.clear();
    await sharedPreferences.setString("country_id", countryCode);
    await sharedPreferences.setString("SelectedLanguageCode", language);
    await sharedPreferences.setInt('theme_option', option);
  }

  /****************empty local storage ************/
  emptyLocalStorage() async {
    _user = null;
    _apiKey = "";
    _loginState = false;
    _selectedChatRoomData = null;
    _homePageData = null;
    _myChatRooms = null;
    _categoryDataList = null;
    _productId4Review = 0;
    _productId4Review = 0;
    _sellerID = 0;
    _selectedSubServiceList = null;
    _selectedRequestData = null;
    _selectedJobData = null;
    _selectedServices = null;
    String countryCode = await sharedPreferences.getString('country_id') ?? "";
    String language =
        await sharedPreferences.getString('SelectedLanguageCode') ?? "";
    int option = sharedPreferences.getInt('theme_option') ?? 0;
    await sharedPreferences.clear();
    await sharedPreferences.setString("country_id", countryCode);
    await sharedPreferences.setString("SelectedLanguageCode", language);
    await sharedPreferences.setInt('theme_option', option);

    _contextData!.pushReplacement(APP_PAGE.signIn.toName);
    showTopSnackBar(
      Overlay.of(_contextData!),
      CustomSnackBar.error(
        message: "Token is invalid or missing, please sign again!",
      ),
    );
  }

  /****************** init user*********************/
  initUser(dynamic response) async {
    await sharedPreferences.setString('apikey', response.data['token']);
    await sharedPreferences.setString(
        'userData', jsonEncode(response.data['data']));

    _user = response.data['data'];
    _apiKey = response.data['token'];
    _loginState = true;
  }

  /****************** check home page data*********************/
  loadLocalData() async {
    var homeData = await sharedPreferences.getString('homepage_data');
    var apiKeyData = await sharedPreferences.getString('apikey');
    if (apiKeyData == null)
      _apiKey = '';
    else
      _apiKey = apiKeyData;
    var categoryData = await sharedPreferences.getString('category_list');
    if (homeData != "" && homeData != null) {
      _homePageData = jsonDecode(homeData);
    } else
      _homePageData = null;
    if (categoryData != "" && categoryData != null) {
      _categoryDataList = jsonDecode(categoryData);
    } else
      _categoryDataList = null;
  }

  checkAuth() async {
    String userData = await sharedPreferences.getString('userData') ?? '';
    if (userData != "" && userData != "null") {
      _user = jsonDecode(userData);
      _loginState = true;
    } else {
      _user = null;
      _loginState = false;
    }
    await loadLocalData();
  }

  setHomePageData(dynamic homePageData) {
    _homePageData = homePageData;
  }

  setKeywords(String keywords) {
    _keywords = keywords;
  }

  setProductAsSeen(dynamic product) async {
    await _homePageData['last_seen']
        .removeWhere((element) => element["id"] == product["id"]);
    await _homePageData['last_seen']
        .insert(_homePageData['last_seen'].length, product);
    if (_homePageData['last_seen'].length > 15) {
      _homePageData['last_seen'].removeAt(0);
    }

    await sharedPreferences.setString(
        'homepage_data', json.encode(_homePageData));
  }

  addFavoriteToHome(dynamic product) async {
    product['favorites'] = 1;
    await _homePageData['favorite']
        .removeWhere((element) => element["id"] == product["id"]);

    await _homePageData['favorite'].insert(0, product);
    if (_homePageData['favorite'].length > 20) {
      _homePageData['favorite'].removeLast();
    }
    await sharedPreferences.setString(
        'homepage_data', json.encode(_homePageData));
  }

  removeFavoriteToHome(dynamic product) async {
    product['favorites'] = 0;
    await _homePageData['favorite']
        .removeWhere((element) => element["id"] == product["id"]);
    await sharedPreferences.setString(
        'homepage_data', json.encode(_homePageData));
  }
  /**
   * @notifications api
   */

  /*******************get notifications ************************/
  Future<dynamic> getNotifications({int? limit = 25, int? offset}) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }

    try {
      Response response = await Api().dio.get('notifications' + filter);

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /***********************mark notification as read *********/
  Future<dynamic> markNotficationAsRead({required int notificationID}) async {
    try {
      Response response = await Api()
          .dio
          .get('notifications/' + notificationID.toString() + '/read');

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get faq list ************************/
  Future<dynamic> getFaqList({int? offset, int? limit = 100}) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }
    try {
      Response response = await Api().dio.get('faqs' + filter);

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/**
 * @pay api part
 */
  /******************* get plans list ************************/
  Future<dynamic> getPlansList() async {
    try {
      Response response = await Api().dio.get('pay/plans');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get credit history ************************/
  Future<dynamic> getCreditHistory({
    int? offset = 0,
    int? limit = 25,
  }) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }
    try {
      Response response = await Api().dio.get('pay/credit-history' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get plans list ************************/
  Future<dynamic> getStripePayment({required int plan_id}) async {
    try {
      Response response =
          await Api().dio.get('pay/' + plan_id.toString() + '/payment-stripe');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/**************order product by BTC  ***************/
  Future<dynamic> newOrderStripe({required int plan_id}) async {
    try {
      Response response =
          await Api().dio.get('pay/' + plan_id.toString() + '/payment-stripe');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get plans list ************************/
  Future<dynamic> getPyamentMethods({required int plan_id}) async {
    try {
      Response response = await Api()
          .dio
          .get('pay/' + plan_id.toString() + '/payments-methods');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* deposit using redeem code ************************/
  Future<dynamic> depositUsingRedeemCode({required String redeemCode}) async {
    try {
      Response response = await Api().dio.post(
            'pay/' + redeemCode + "/deposit",
          );
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* location auto complete ************************/
  Future<dynamic> getMyLocation(
      {required String latitude, required String longitude}) async {
    try {
      String filter = '?lat=$latitude&lon=$longitude';

      Response response = await Api().dio.get('location/my-location' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* location auto complete ************************/
  Future<dynamic> locationAutoComplete(
      {required String city, int? limit = 25, int? offset}) async {
    try {
      String filter = '?limit=$limit';
      if (offset != null) {
        filter += '&offset=$offset';
      }

      filter += '&search=$city';

      Response response =
          await Api().dio.get('location/location-autocomplete' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* location auto complete ************************/
  Future<dynamic> autoComplete({required String city}) async {
    try {
      String filter = '';

      filter += '?keyword=$city' + '&country=Romania';

      Response response = await Api().dio.get('location/autocomplete' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* location auto complete ************************/
  Future<dynamic> location2geo({required String address}) async {
    try {
      String filter = '';

      filter += '?address=$address';

      Response response = await Api().dio.get('location/location2geo' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get my locations ************************/
  Future<dynamic> getMyLocations() async {
    try {
      Response response = await Api().dio.get('location/my-locations');

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* append my locations ************************/

  Future<dynamic> appendLocation() async {
    try {
      Response response = await Api().dio.put('location/user-locations');

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* set locations ************************/
  Future<dynamic> setLocation({required dynamic cityList}) async {
    try {
      dynamic array = [];
      String data = '[';
      for (int i = 0; i < cityList.length; i++) {
        array.add(cityList[i]['id']);
        if (i != cityList.length - 1)
          data = data + cityList[i]['id'].toString() + ",";
        else
          data = data + cityList[i]['id'].toString();
      }
      data = data + ']';
      Response response = await Api().dio.post('location/user-locations',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'city_ids': data});

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* delete user locations ************************/
  Future<dynamic> deleteUserLocation() async {
    try {
      Response response = await Api().dio.delete('location/user-locations');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* set User Location ************************/
  Future<dynamic> setUserLocation() async {
    try {
      Response response = await Api().dio.get('faqs');

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/**
 * @Service api part
 */

  /******************* get all services ************************/
  Future<dynamic> getAllServices({
    int? offset,
    int? limit = 25,
  }) async {
    String filter = '?limit=$limit';
    if (offset != null) {
      filter += '&offset=$offset';
    }
    try {
      Response response = await Api().dio.get('services/' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get all services ************************/
  Future<dynamic> getAllServices1() async {
    try {
      Response response = await Api().dio.get('home/services-all');
      await sharedPreferences.setString(
          'homepage_data', json.encode(response.data));
      _homePageData = response.data;
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* append services ************************/
  Future<dynamic> appendServices() async {
    try {
      Response response = await Api().dio.put('services/my-services');

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* delete services ************************/
  Future<dynamic> deleteServices({required int service_id}) async {
    try {
      Response response = await Api().dio.delete('services/my-services',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'service_ids': service_id.toString()});

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* set  services ************************/
  Future<dynamic> addMyService({required dynamic serviceList}) async {
    try {
      String data = '[';
      for (int i = 0; i < serviceList.length; i++) {
        if (i != serviceList.length - 1)
          data = data + serviceList[i]['id'].toString() + ",";
        else
          data = data + serviceList[i]['id'].toString();
      }
      data = data + ']';
      Response response = await Api().dio.post('services/my-services',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'service_ids': data});
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* set  services ************************/
  Future<dynamic> setServices() async {
    try {
      String data = '[';
      for (int i = 0; i < _selectedSubServiceList.length; i++) {
        if (i != _selectedSubServiceList.length - 1)
          data = data + _selectedSubServiceList[i]['id'].toString() + ",";
        else
          data = data + _selectedSubServiceList[i]['id'].toString();
      }
      data = data + ']';
      Response response = await Api().dio.post('services/my-services',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'service_ids': data});
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/******************* get service by id ************************/
  Future<dynamic> getServiceById({required int serviceID}) async {
    try {
      Response response =
          await Api().dio.get('services/' + serviceID.toString());
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/******************* set cities to user ************************/
  Future<dynamic> setCitiesToUser() async {
    try {
      String data = '[';
      for (int i = 0; i < _selectedCities.length; i++) {
        if (i != _selectedCities.length - 1)
          data = data + _selectedCities[i]['id'].toString() + ",";
        else
          data = data + _selectedCities[i]['id'].toString();
      }
      data = data + ']';
      Response response = await Api().dio.post('services/cities',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'city_ids': data});
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/******************* update cities to user ************************/
  Future<dynamic> updateCitiesToUser() async {
    try {
      String data = '[';
      for (int i = 0; i < _selectedCities.length; i++) {
        if (i != _selectedCities.length - 1)
          data = data + _selectedCities[i]['id'].toString() + ",";
        else
          data = data + _selectedCities[i]['id'].toString();
      }
      data = data + ']';
      Response response = await Api().dio.put('services/cities',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'city_ids': data});
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/******************* set locations ************************/
  Future<dynamic> addMyCities({required dynamic cityList}) async {
    try {
      dynamic array = [];
      String data = '[';
      for (int i = 0; i < cityList.length; i++) {
        array.add(cityList[i]['id']);
        if (i != cityList.length - 1)
          data = data + cityList[i]['id'].toString() + ",";
        else
          data = data + cityList[i]['id'].toString();
      }
      data = data + ']';
      Response response = await Api().dio.post('service/cities',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'city_ids': data});

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/******************* delete cities ************************/
  Future<dynamic> deleteCities({required int city_id}) async {
    try {
      Response response = await Api().dio.delete('services/cities',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {'city_ids': city_id.toString()});

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

/**
 * @request api part
 */

  /******************* get offers by request id ************************/
  Future<dynamic> getOffersById({required int requestID}) async {
    try {
      Response response =
          await Api().dio.get('request/' + requestID.toString() + '/offers');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get offer by offer id ************************/
  Future<dynamic> getOfferById({required int offerID}) async {
    try {
      Response response =
          await Api().dio.get('request/offer/' + offerID.toString());
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get my requests ************************/
  Future<dynamic> getMyRequests({
    int? offset,
    int? limit = 25,
    String? searchKey,
    bool is_active = true,
  }) async {
    try {
      String filter = '?limit=$limit';
      if (offset != null) {
        filter += '&offset=$offset';
      }
      if (searchKey != null) {
        filter += '&search=$searchKey';
      }
      filter += '&is_active=$is_active';
      Response response = await Api().dio.get('request/' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* browse requests ************************/
  Future<dynamic> browseRequests(
      {int? offset = 0,
      int? limit = 25,
      String? searchKey,
      String? priority,
      int? service_id,
      int? city_id}) async {
    try {
      String filter = '?limit=$limit';
      if (offset != null) {
        filter += '&offset=$offset';
      }
      if (searchKey != null) {
        filter += '&search=$searchKey';
      }
      if (priority != null) {
        filter += '&priority=' + priority.toString();
      }
      if (service_id != null) {
        filter += '&service_id=' + service_id.toString();
      }
      if (city_id != null) {
        filter += '&city_id=' + city_id.toString();
      }
      Response response = await Api().dio.get('request/browse' + filter);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* cancel offer by Id ************************/
  Future<dynamic> cancelOfferById(
      {required int offerID, required int reason}) async {
    FormData formData = FormData.fromMap({
      "reason": reason,
    });
    try {
      Response response = await Api().dio.post(
          'request/offer/' + offerID.toString() + "/cancel",
          data: formData);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* cancel request by Id ************************/
  Future<dynamic> cancelRequestById(
      {required int requestID, required int reason}) async {
    FormData formData = FormData.fromMap({
      "reason": reason,
    });
    try {
      Response response = await Api()
          .dio
          .post('request/' + requestID.toString() + "/cancel", data: formData);
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get request by Id ************************/
  Future<dynamic> getRequestById({required int requestID}) async {
    try {
      Response response = await Api().dio.post(
            'request/' + requestID.toString() + "/item",
          );
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* get request info by Id ************************/
  Future<dynamic> getRequestInfoId({required int requestID}) async {
    try {
      Response response = await Api().dio.get(
            'request/' + requestID.toString() + "/info",
          );
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  Future<void> checkCountryRegistered() async {
    String data = await sharedPreferences.getString(
          "country_id",
        ) ??
        "";

    if (data != "")
      _countryRegistered = true;
    else
      _countryRegistered = false;
  }

  Future<void> registerCountry(String data) async {
    await sharedPreferences.setString("country_id", data);
  }

  /******************* create new offer to request Id ************************/
  Future<dynamic> createNewOfferForRequestID(
      {required int price,
      required String description,
      int? deadline,
      String? offer_type,
      required String currency_type,
      String? available_from,
      required int requestID}) async {
    try {
      FormData formData = FormData.fromMap({
        "price": price,
        "description": description,
        "dead_line": deadline,
        "offer_type": offer_type,
        "available_from": available_from,
        "currency_type": currency_type
      });

      Response response =
          await Api().dio.post('request/' + requestID.toString() + "/offer",
              data: formData,
              options: Options(
                headers: {
                  'content-type': 'application/x-www-form-urlencoded',
                  'accept': 'application/json'
                },
              ));
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* create new offer to request Id ************************/
  Future<dynamic> uddateOfferByID(
      {required int price,
      required String description,
      required int deadline,
      required String offer_type,
      required String currency_type,
      String available_from = '',
      required int offerID}) async {
    try {
      FormData formData = FormData.fromMap({
        "price": price,
        "description": description,
        "dead_line": deadline,
        "offer_type": offer_type,
        "available_from": available_from,
        "currency_type": currency_type
      });

      Response response = await Api()
          .dio
          .post('request/offer/' + offerID.toString() + "/update",
              data: formData,
              options: Options(
                headers: {
                  'content-type': 'application/x-www-form-urlencoded',
                  'accept': 'application/json'
                },
              ));
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* unlock request by Id ************************/
  Future<dynamic> unlockRequestById({required int requestID}) async {
    try {
      Response response =
          await Api().dio.post('request/' + requestID.toString() + '/unlock');
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* post request item ************************/
  Future<dynamic> createNewRequest(
      {required String full_name,
      required String phone,
      int? city_id,
      String address = '',
      String files = '',
      required String description,
      required String when_need,
      required String when_need_date,
      required String questions,
      required int service_id,
      required String latitude,
      required String phone_options,
      required String priority,
      required String longitude}) async {
    try {
      dynamic formData = questions == ""
          ? files != ''
              ? {
                  "full_name": full_name,
                  "phone": phone,
                  "address": address,
                  "city_id": city_id,
                  "files": files,
                  "description": description,
                  "when_need": when_need,
                  "when_need_date": when_need_date,
                  "latitude": latitude,
                  "longitude": longitude,
                  "phone_options": phone_options,
                  'priority': priority,
                }
              : {
                  "full_name": full_name,
                  "phone": phone,
                  "address": address,
                  "city_id": city_id,
                  "description": description,
                  "when_need": when_need,
                  "when_need_date": when_need_date,
                  "latitude": latitude,
                  "longitude": longitude,
                  "phone_options": phone_options,
                  'priority': priority,
                }
          : files != ''
              ? {
                  "full_name": full_name,
                  "phone": phone,
                  "address": address,
                  "city_id": city_id,
                  "files": files,
                  "description": description,
                  "when_need": when_need,
                  "questions": questions,
                  "when_need_date": when_need_date,
                  "latitude": latitude,
                  "longitude": longitude,
                  "phone_options": phone_options,
                  'priority': priority,
                }
              : {
                  "full_name": full_name,
                  "phone": phone,
                  "address": address,
                  "city_id": city_id,
                  "description": description,
                  "when_need": when_need,
                  "questions": questions,
                  "when_need_date": when_need_date,
                  "latitude": latitude,
                  "longitude": longitude,
                  "phone_options": phone_options,
                  'priority': priority,
                };
      Response response =
          await Api().dio.post('request/' + service_id.toString(),
              data: formData,
              options: Options(
                headers: {
                  'content-type': 'application/x-www-form-urlencoded',
                  'accept': 'application/json'
                },
              ));
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /***********add product image ***************/
  Future<dynamic> addServiceImage({
    required File serviceImage,
  }) async {
    try {
      Response? response;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(serviceImage.path,
            filename: serviceImage.path.split('/').last),
      });
      response = await Api().dio.post('upload/',
          data: formData,
          options: Options(
            headers: {
              'content-type': 'multipart/form-data',
              'accept': 'application/json'
            },
          ));

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /***********write user review ***************/
  Future<dynamic> writeUserReview(
      {required String review,
      required int requestID,
      required int userID,
      required bool is_hidden,
      required int rating}) async {
    try {
      Response? response;
      FormData formData = FormData.fromMap(
          {'rating': rating, 'review': review, "is_hidden": is_hidden});
      response = await Api().dio.post(
          'request/' + requestID.toString() + '/review/' + userID.toString(),
          data: formData,
          options: Options(
            headers: {
              'content-type': 'multipart/form-data',
              'accept': 'application/json'
            },
          ));

      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  /******************* cancel offer by Id ************************/
  Future<dynamic> becomeSeller(
      {required String company_name,
      required String company_number,
      required String address,
      required String phone,
      required String description,
      required String lat,
      required String lon,
      String? website,
      String? youtube,
      String? tiktok,
      String? whatsapp,
      String? facebook}) async {
    FormData formData = FormData.fromMap({
      "company_name": company_name,
      "company_number": company_number,
      "address": address,
      "phone": phone,
      "description": description,
      "website": website,
      "youtube": youtube,
      "tiktok": tiktok,
      "whatsapp": whatsapp,
      "facebook": facebook,
      "lat": lat,
      "lon": lon,
    });
    try {
      Response response = await Api().dio.post('user/become-a-seller',
          data: formData,
          options: Options(
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
              'accept': 'application/json'
            },
          ));
      return response;
    } on Exception catch (e) {
      if (e.toString() == invalidToken || e.toString() == missingToken)
        emptyLocalStorage();
      return e.toString();
    }
  }

  of(BuildContext context) {}
}

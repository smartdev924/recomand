import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/models/user_info.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../size_config.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoggedOut = false;
  bool isSeller = false;
  dynamic avatarUrl;

  String userName = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    setState(() {
      avatarUrl =
          _appService.user['avatar'] == '' ? null : _appService.user['avatar'];
      userName = _appService.user['full_name'] == null
          ? 'Unnamed'
          : _appService.user['full_name'];
      if (_appService.user['is_worker'] == false)
        isSeller = false;
      else
        isSeller = (_appService.user['user_type'] == "work");
    });

    authMe();
    super.initState();
  }

  Future<void> authMe() async {
    try {
      final response = await _appService.getUserInfo();
      if (response is String) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: response,
          ),
        );
      } else {
        _appService.user = response.data['data'];
        setState(() {
          if (_appService.user['is_worker'] == false)
            isSeller = false;
          else
            isSeller = (_appService.user['user_type'] == "work");
          avatarUrl = _appService.user['avatar'] == ''
              ? null
              : _appService.user['avatar'];
          userName = _appService.user['full_name'] == null
              ? 'Unnamed'
              : _appService.user['full_name'];
        });
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadNewAvatar() async {
    UserInfo user = UserInfo();
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "image not selected",
          ),
        );
        return;
      }
      final File? imageTemp = File(image.path);
      user.fullName = _appService.user["full_name"];
      user.tz = _appService.user["tz"];
      user.email = _appService.user["email"];
      user.avatar = imageTemp;
      final response = await _appService.updateUser(user: user);
      if (response is String) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: response,
          ),
        );
      } else {
        setState(() => {
              avatarUrl = response.data['avatar'],
              userName = response.data['full_name'],
            });
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<void> submitName(String f_name) async {
    UserInfo user = UserInfo();
    try {
      user.fullName = f_name;
      user.tz = _appService.user["tz"];
      user.email = _appService.user["email"];
      final response = await _appService.updateUserName(user: user);
      if (response is String) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: response,
          ),
        );
      } else {
        setState(() => {
              userName = response.data['full_name'],
            });
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _textEditingController,
                  validator: (value) {
                    return value!.isNotEmpty
                        ? null
                        : Languages.of(context)!.inputName;
                  },
                  decoration: InputDecoration(
                      hintText: Languages.of(context)!.inputName),
                ),
              ),
              title: Text(Languages.of(context)!.name),
              actions: <Widget>[
                InkWell(
                  child: Text(Languages.of(context)!.lab_send + '    '),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      submitName(_textEditingController.text);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> uploadNewAvatarFromFiles() async {
    UserInfo user = UserInfo();
    try {
      FilePickerResult? image = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'png',
          'bmp',
          'gif',
          'mov',
          'avi',
          'wmv',
          'mp4',
        ],
      );
      if (image == null) {
        return;
      }
      final File? imageTemp = File(image.paths[0].toString());
      user.fullName = _appService.user["full_name"];
      user.tz = _appService.user["tz"];
      user.email = _appService.user["email"];
      user.avatar = imageTemp;
      final response = await _appService.updateUser(user: user);
      if (response is String) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: response,
          ),
        );
      } else {
        setState(() => {
              avatarUrl = response.data['avatar'],
              userName = response.data['full_name'],
            });
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  _onMenuItemSelected(int value) {
    setState(() {
      // _popupMenuItemIndex = value;
    });

    if (value == 1) {
      uploadNewAvatarFromFiles();
    }
    if (value == 2) {
      if (!kIsWeb) if (Platform.isAndroid || Platform.isIOS) uploadNewAvatar();
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: _appService.user == null
            ? Container()
            : Column(children: [
                SizedBox(height: getProportionateScreenHeight(40)),
                Row(
                  children: [
                    PopupMenuButton(
                        onSelected: (value) {
                          _onMenuItemSelected(value as int);
                        },
                        // initialValue: 2,
                        child: Container(
                            child: avatarUrl == null
                                ? Image.asset(
                                    'assets/images/profile_sm.png',
                                    width: 48,
                                    height: 48,
                                  )
                                : ExtendedImage.network(
                                    avatarUrl,
                                    fit: BoxFit.cover,
                                    height: 48,
                                    width: 48,
                                    cacheHeight: 48,
                                    cacheWidth: 48,
                                    compressionRatio: 0.5,
                                    cache: true,
                                    shape: BoxShape.circle,
                                    clearMemoryCacheIfFailed: true,
                                    clearMemoryCacheWhenDispose: true,
                                    loadStateChanged:
                                        (ExtendedImageState state) {
                                      switch (state.extendedImageLoadState) {
                                        case LoadState.failed:
                                          return Image.asset(
                                            'assets/images/profile_sm.png',
                                            width: 48,
                                            height: 48,
                                          );

                                        case LoadState.loading:
                                          return Image.asset(
                                            'assets/images/profile_sm.png',
                                            width: 48,
                                            height: 48,
                                          );
                                        case LoadState.completed:
                                          break;
                                      }
                                      return null;
                                    },
                                  )),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Text(
                                  Languages.of(context)!.fromFiles,
                                  style: TextStyle(
                                      color: context
                                              .watch<AppService>()
                                              .themeState
                                              .customColors[
                                          AppColors.primaryTextColor1]),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text(
                                  Languages.of(context)!.fromCamera,
                                  style: TextStyle(
                                      color: context
                                              .watch<AppService>()
                                              .themeState
                                              .customColors[
                                          AppColors.primaryTextColor1]),
                                ),
                              )
                            ]),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(APP_PAGE.myAccount.toName);
                        },
                        child: Text(
                          userName,
                          style: TextStyle(
                              color: context
                                  .watch<AppService>()
                                  .themeState
                                  .customColors[AppColors.primaryTextColor1],
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: IconButton(
                            onPressed: () {
                              GoRouter.of(context)
                                  .pushNamed(APP_PAGE.settings.toName);
                            },
                            icon: Icon(
                              Icons.settings_outlined,
                              size: 25,
                            ))),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(40)),
                InkWell(
                  onLongPress: () {
                    GoRouter.of(context)
                        .pushNamed(APP_PAGE.creditHistory.toName);
                  },
                  onTap: () {
                    if (kIsWeb)
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.buyCredits.toName);
                    else if (Platform.isIOS) {
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.buyCreditsApple.toName);
                    } else {
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.buyCredits.toName);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(181, 228, 202, 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/buy_coins.png',
                          fit: BoxFit.cover,
                          width: 30,
                          // height: double.infinity,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Text(
                          _appService.user == null
                              ? '0'
                              : _appService.user['credits'].toString() +
                                  ' ' +
                                  Languages.of(context)!.coins,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(43, 44, 46, 1)),
                        )),
                        Icon(Icons.add_box_outlined,
                            color: Color.fromRGBO(43, 44, 46, 1))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      if (!isSeller)
                        InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(APP_PAGE.myJobs.toName);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 18, bottom: 18),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Color.fromRGBO(224, 224, 224, 1)),
                                ),
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/Orders.png',
                                      fit: BoxFit.cover,
                                      width: 24,
                                      color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .isDarkTheme ==
                                              true
                                          ? Colors.white
                                          : Colors.black),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        Languages.of(context)!.my_jobs,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: context
                                                    .watch<AppService>()
                                                    .themeState
                                                    .customColors[
                                                AppColors.primaryTextColor1]),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.chevron_right,
                                          color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .customColors[
                                              AppColors.primaryTextColor1])),
                                ],
                              ),
                            )),
                      if (isSeller)
                        InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(APP_PAGE.myOffers.toName);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 18, bottom: 18),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Color.fromRGBO(224, 224, 224, 1)),
                                ),
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/Orders.png',
                                      fit: BoxFit.cover,
                                      width: 24,
                                      color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .isDarkTheme ==
                                              true
                                          ? Colors.white
                                          : Colors.black),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        Languages.of(context)!.myOffers,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: context
                                                    .watch<AppService>()
                                                    .themeState
                                                    .customColors[
                                                AppColors.primaryTextColor1]),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.chevron_right,
                                          color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .customColors[
                                              AppColors.primaryTextColor1])),
                                ],
                              ),
                            )),
                      if (isSeller)
                        InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(APP_PAGE.myServices.toName);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 18, bottom: 18),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Color.fromRGBO(224, 224, 224, 1)),
                                ),
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/my_services.png',
                                      fit: BoxFit.cover,
                                      width: 24,
                                      color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .isDarkTheme ==
                                              true
                                          ? Colors.white
                                          : Colors.black),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        Languages.of(context)!.myServices,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: context
                                                    .watch<AppService>()
                                                    .themeState
                                                    .customColors[
                                                AppColors.primaryTextColor1]),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.chevron_right,
                                          color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .customColors[
                                              AppColors.primaryTextColor1])),
                                ],
                              ),
                            )),
                      InkWell(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(APP_PAGE.notifications.toName);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 18, bottom: 18),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(224, 224, 224, 1)),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Stack(children: [
                                  Image.asset('assets/images/notification.png',
                                      fit: BoxFit.cover,
                                      width: 24,
                                      color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .isDarkTheme ==
                                              true
                                          ? Colors.white
                                          : Colors.black),
                                  if (_appService.receivedNewNotification)
                                    Positioned(
                                        left: 13,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ))
                                ]),
                                SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    Languages.of(context)!.notificaiton,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: context
                                                .watch<AppService>()
                                                .themeState
                                                .customColors[
                                            AppColors.primaryTextColor1]),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.chevron_right,
                                        color: context
                                                .watch<AppService>()
                                                .themeState
                                                .customColors[
                                            AppColors.primaryTextColor1])),
                              ],
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            GoRouter.of(context).pushNamed(APP_PAGE.faq.toName);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 18, bottom: 18),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(224, 224, 224, 1)),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/images/faq.png',
                                    fit: BoxFit.cover,
                                    width: 24,
                                    color: context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme ==
                                            true
                                        ? Colors.white
                                        : Colors.black),
                                SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      Languages.of(context)!.FAQ,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .customColors[
                                              AppColors.primaryTextColor1]),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.chevron_right,
                                        color: context
                                                .watch<AppService>()
                                                .themeState
                                                .customColors[
                                            AppColors.primaryTextColor1])),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                !_appService.user['is_worker']
                    ? InkWell(
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(APP_PAGE.workStep1.toName);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 243, 245, 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/become_seller.png',
                                fit: BoxFit.cover,
                                width: 30,
                                // height: double.infinity,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Text(
                                Languages.of(context)!.become_seller,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(43, 44, 46, 1)),
                              ))
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          String type = 'hire';
                          if (_appService.user['user_type'] == "hire")
                            type = 'work';
                          dynamic response =
                              await _appService.changeUserType(type: type);
                          if (response is String || response == null)
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message: response,
                              ),
                            );
                          else if (response.data['success'] == false)
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message: response.data['message'],
                              ),
                            );
                          else {
                            GoRouter.of(context).pop();
                            GoRouter.of(context)
                                .pushNamed(APP_PAGE.myAccountSettings.toName);
                          }
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(242, 243, 245, 1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        _appService.user['user_type'] == "work"
                                            ? Languages.of(context)!
                                                .switchToHire
                                            : Languages.of(context)!
                                                .switchToWorker,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(43, 44, 46, 1)),
                                      )))
                            ]),
                      ),
                SizedBox(height: getProportionateScreenHeight(20)),
              ]),
      ),
    );
  }
}

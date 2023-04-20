import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/app_router.dart';
import 'package:localservice/services/AppService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'localization/localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:uni_links/uni_links.dart';

bool _initialUriIsHandled = false;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);

  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
GlobalKey<NavigatorState> navigatorKey = GlobalKey();
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  const String darwinNotificationCategoryPlain = 'plainCategory';
  const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );

  if (notification != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
          ),
          iOS: iosNotificationDetails),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String data = await sharedPreferences.getString(
        "country_id",
      ) ??
      "";
  AppService appService = AppService(sharedPreferences);
  if (data != "")
    appService.countryRegistered = true;
  else
    appService.countryRegistered = false;
  await appService.checkAuth();
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      await Firebase.initializeApp();

      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      // Set the background messaging handler early on, as a named top-level function
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      await setupFlutterNotifications();
    }
  }
  runApp(MyApp(
    appService: appService,
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatefulWidget {
  final AppService appService;
  final SharedPreferences sharedPreferences;
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  const MyApp({
    Key? key,
    required this.appService,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  bool checkingInstalled = false;

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) _handleInitialUri();
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        _sub = uriLinkStream.listen((Uri? uri) {
          if (!mounted) return;

          if (uri.toString().contains('request')) {
            widget.appService.deeplinkRequestID =
                uri.toString().split('/').last.toString();
          }
          if (uri.toString().contains('register')) {
            widget.appService.inviteCode =
                uri.toString().split('/').last.toString();
          }
        }, onError: (Object err) {
          if (!mounted) return;
          setState(() {
            if (err is FormatException) {
            } else {}
          });
        });
      }
    }
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        await getInitialUri();

        if (!mounted) return;
      } on PlatformException {
      } on FormatException {
        if (!mounted) return;
      }
    }
  }

  List<String>? getCmds() {
    late final String cmd;
    var cmdSuffix = '';

    const plainPath = 'path/subpath';
    const args = 'path/portion/?uid=123&token=abc';
    const emojiArgs =
        '?arr%5b%5d=123&arr%5b%5d=abc&addr=1%20Nowhere%20Rd&addr=Rand%20City%F0%9F%98%82';

    if (kIsWeb) {
      return [
        plainPath,
        args,
        emojiArgs,
      ];
    }

    if (Platform.isIOS) {
      cmd = '/usr/bin/xcrun simctl openurl booted';
    } else if (Platform.isAndroid) {
      cmd = '\$ANDROID_HOME/platform-tools/adb shell \'am start'
          ' -a android.intent.action.VIEW'
          ' -c android.intent.category.BROWSABLE -d';
      cmdSuffix = "'";
    } else {
      return null;
    }

    // https://orchid-forgery.glitch.me/mobile/redirect/
    return [
      '$cmd "unilinks://host/$plainPath"$cmdSuffix',
      '$cmd "unilinks://example.com/$args"$cmdSuffix',
      '$cmd "unilinks://example.com/$emojiArgs"$cmdSuffix',
      '$cmd "unilinks://@@malformed.invalid.url/path?"$cmdSuffix',
    ];
  }

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          widget.appService.themeState = themeState;
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<AppService>(
                    create: (_) => widget.appService),
                Provider<AppRouter>(
                    create: (_) => AppRouter(widget.appService)),
              ],
              child: Builder(builder: (context) {
                final GoRouter goRouter =
                    Provider.of<AppRouter>(context, listen: false).router;
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Recomand',
                  theme: themeState.themeData,
                  routeInformationProvider: goRouter.routeInformationProvider,
                  routeInformationParser: goRouter.routeInformationParser,
                  routerDelegate: goRouter.routerDelegate,
                  locale: _locale,
                  supportedLocales: [
                    Locale('en', 'US'),
                    Locale('ro', 'RO'),
                    Locale('it', 'IT'),
                    Locale('es', 'ES'),
                    Locale('fr', 'FR'),
                    Locale('ru', 'RU'),
                    Locale('de', 'DE'),
                  ],
                  localizationsDelegates: [
                    AppLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (locale, supportedLocales) {
                    String languageCode = widget.sharedPreferences
                            .getString("SelectedLanguageCode") ??
                        "";
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode == languageCode) {
                        return supportedLocale;
                      }
                    }
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode ==
                          locale?.languageCode) {
                        widget.sharedPreferences.setString(
                            "SelectedLanguageCode",
                            supportedLocale.languageCode);
                        return supportedLocale;
                      }
                    }
                    widget.sharedPreferences.setString("SelectedLanguageCode",
                        supportedLocales.first.languageCode);
                    return supportedLocales.first;
                  },
                );
              }));
        });
  }
}

class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  const NoAnimationPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:chat_app/utils/app.dart';
import 'package:chat_app/utils/app_localizations.dart';
import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/route_generator.dart';
import 'package:chat_app/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chat_app/data/sources/moor_database/moor_database.dart';

void main() {
  //print(SharedPreferences.getInstance().toString());
  //SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String userId;
  static AppDataBase appDataBase = AppDataBase();

  static void setLocale(BuildContext context, Locale newLocale) async {
    context.findAncestorStateOfType<_MyAppState>().changeLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;
  bool localeLoaded = false;
  //bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    initializeFirebase();
    super.initState();

    this._fetchLocale().then((locale) {
      setState(() {
        this.localeLoaded = true;
        this.locale = locale;
      });
    });
  }

  changeLocale(Locale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('languageCode') == null) {
      return null;
    }

    return Locale(prefs.getString('languageCode'));
  }

  void initializeFirebase() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      /*setState(() {
        _initialized = true;
      });*/
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Text("error");
    }

    return MaterialApp(
      title: "chat App",
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: AppTheme.lightGrey,
        buttonColor: AppTheme.appBarColor,
        primarySwatch: AppTheme.appColorSelector,
        primaryColor: AppTheme.appBarColor,
        textTheme: AppTheme.textTheme,
      ),
      supportedLocales: application.supportedLocales(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      locale: locale,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      initialRoute: Constants.splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

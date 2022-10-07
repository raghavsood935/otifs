

import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';

import 'package:stellar_track/Screens/Main%20Screens/bookacall.dart';
import 'package:stellar_track/Screens/Main%20Screens/booking_lists_screen.dart';
import 'package:stellar_track/Screens/Main%20Screens/cart_screen.dart';
import 'package:stellar_track/Screens/Main%20Screens/home_page.dart';
import 'package:stellar_track/api_calls.dart';

import 'package:stellar_track/functions.dart';
import 'package:stellar_track/themes.dart';
import 'package:stellar_track/widgets/bottom_nav.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Screens/Main Screens/account_section_screen.dart';
import 'Screens/splash_screen.dart';
import 'controllers.dart';

List<Widget> screens = const [
  HomePage(),
  BookACallPage(),
  CartScreen(
    isBottomNav: true,
  ),
  BookingListsScreen(),
  AccountSectionScreen(),
];


void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final getStorage = GetStorage();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeClass.lightTheme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
          title: 'Flutter Demo Home Page',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.analytics, required this.observer}) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    widget.analytics.setCurrentScreen(screenName: "HomePage");
     widget.analytics.logShare(contentType: "App Link", itemId: "Unique", method: "Application");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // getStorage.write('refUserId', '');
    return const Scaffold(extendBodyBehindAppBar: false, body: SplashScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Controller c = Get.put(Controller());
  dynamic appversion;
  @override
  void initState() {
    super.initState();
    getAppVersions().then((value){
      setState(() {
        appversion = value;
        versionCheck(context, appversion);
      });
    });
    getAllServices().then((res) {
      setState(() {
        c.allServicesMap.value = res;
      });
    });
  }
  Future versionCheck(context,appversion) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    try {
      double newVersion = double.parse(appversion["data"]["android_version"]
          .trim()
          .replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      }
    } catch (exception) {
      // Fetch throttled.
      print(exception);
    }
  }
  _showVersionDialog(context) async {
    const APP_STORE_URL =
        '';
    const PLAY_STORE_URL =
        'https://play.google.com/store/apps/details?id=com.app.OTIFs';
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(APP_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
            : AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(PLAY_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    // var wd = MediaQuery.of(context).size.width;
    var ht = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        bottomNavigationBar: Container(
            height: ht / 14.5,
            // width: wd,
            color: Colors.white,
            child: BottomNavigation(
              height: ht / 14.5,
            )),
        body: SafeArea(
          child: screens[c.screenIndex.value],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

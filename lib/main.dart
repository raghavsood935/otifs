import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/Screens/homeScreen.dart';
import 'package:stellar_track/Screens/screen1.dart';
import 'package:stellar_track/themes.dart';
import 'package:stellar_track/widgets/bottomNav.dart';
import 'Screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeClass.lightTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    return const SafeArea(
      child: Scaffold(
        body: SplashScreen(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

List<Widget> screens = const [HomePage(), RandomScreen(), RandomScreen()];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: screens[index],
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                height: wd / 4.8, color: Colors.white, child: BottomNavigation()
                // BottomNavigationBar(
                //     iconSize: 18,
                //     // elevation: ,
                //     backgroundColor: Colors.white,
                //     fixedColor: Colors.black,
                //     // selectedItemColor: Colors.black,
                //     unselectedItemColor: Colors.black,
                //     selectedFontSize: 12,
                //     showSelectedLabels: true,
                //     showUnselectedLabels: true,
                //     currentIndex: index,
                //     // unselectedLabelStyle: TextStyle(color: Colors.black),
                //     // selectedLabelStyle: TextStyle(color: Colors.black),
                //     onTap: (value) {
                //       setState(() {
                //         index = value;
                //       });
                //     },
                //     items: [
                //       BottomNavigationBarItem(
                //         backgroundColor: Colors.white,
                //         icon: Image.asset(
                //           "assets/icons/BottomNav/home.png",
                //           height: 24,
                //         ),
                //         label: "Home",
                //       ),
                //       BottomNavigationBarItem(
                //           icon: Image.asset(
                //             "assets/icons/BottomNav/call.png",
                //             height: 24,
                //           ),
                //           label: "Book on call"),
                //       BottomNavigationBarItem(
                //           icon: Image.asset(
                //             "assets/icons/BottomNav/cart.png",
                //             height: 24,
                //           ),
                //           label: "Service cart"),
                //       BottomNavigationBarItem(
                //           icon: Image.asset(
                //             "assets/icons/BottomNav/bookings.png",
                //             height: 24,
                //           ),
                //           label: "Bookings"),
                //       BottomNavigationBarItem(
                //           icon: Image.asset(
                //             "assets/icons/BottomNav/account.png",
                //             height: 24,
                //           ),
                //           label: "Account")
                //     ]),
                ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

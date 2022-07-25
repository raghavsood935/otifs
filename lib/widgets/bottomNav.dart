import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: wd / 5,
            color: Colors.white,
            child: BottomNavigationBar(
                iconSize: 18,
                // elevation: ,
                backgroundColor: Colors.white,
                fixedColor: Colors.black,
                // selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black,
                selectedFontSize: 12,
                showSelectedLabels: true,
                showUnselectedLabels: true,

                // unselectedLabelStyle: TextStyle(color: Colors.black),
                // selectedLabelStyle: TextStyle(color: Colors.black),

                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Image.asset(
                      "assets/icons/BottomNav/home.png",
                      height: 24,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/BottomNav/call.png",
                        height: 24,
                      ),
                      label: "Book on call"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/BottomNav/cart.png",
                        height: 24,
                      ),
                      label: "Service cart"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/BottomNav/bookings.png",
                        height: 24,
                      ),
                      label: "Bookings"),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/BottomNav/account.png",
                        height: 24,
                      ),
                      label: "Account")
                ]),
          ),
        ),
      ),
    );
  }
}

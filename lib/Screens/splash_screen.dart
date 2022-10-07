import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/Screens/signup_screen.dart';
import 'package:stellar_track/widgets/logo.dart';
import '../controllers.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final Controller c = Get.put(Controller());
  String? position;
  late final AnimationController controller;
  Animation<double>? animation;
  double height = 200.0;
  bool selected = false;
  bool textbool = false;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    ); // <-- Set your duration here.
    animation = Tween(begin: 0.0, end: 0.0).animate(controller);
    controller.forward();
    position = "initial";
    getStorage.read('refUserId') != null
        ? saveRefId(getStorage.read('refUserId'))
        : saveRefId('');
    _changeposition();
    _gotohome();
  }


  saveRefId(id) {
    c.refUserId.value = id;
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    _playAnimation();
    return Scaffold(
      backgroundColor: Color(0xff38456C),
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              top: selected ? ht/2.5 : 0.0,
              left: selected ? 70.0 : 0.0,
              duration: Duration(seconds: 3),
              curve: Curves.fastOutSlowIn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: ht / 7.5,
                    width: ht / 8,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "OTIFS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff38456C)),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  textbool ? Align(
                    alignment: Alignment.center,
                    child: Text("Happy to Serve,\nAlways",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.white)
                    ),
                  ) : Container()
                ],
              )
            ),
          ],
        ),

      ),
    );
  }

  void _changeposition(){
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        position = "Change";
        selected = true;
      });
    });
  }
  void _playAnimation() {
    Future.delayed(Duration(seconds: 4),(){
      setState(() {
        textbool = true;
      });
    });
  }

  void _gotohome() {
    Future.delayed(Duration(seconds: 5),(){
      setState(() {
        if(getStorage.read('refUserId') == null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              SignUpScreen()
          ));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              HomeScreen()
          ));
        }
      });
    });
  }

  Widget _animatedcontainer(double ht){
    return AnimatedSplashScreen(
      backgroundColor: const Color(0xff38456C),
      duration: 2500,
      splashIconSize: ht/8,

      splash: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Logo(ht: ht)
      ),
      nextScreen: getStorage.read('refUserId') == null
          ? const SignUpScreen()
          : const SafeArea(child: HomeScreen()
      ),
    );
  }
}

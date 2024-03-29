import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/api_calls.dart';
import 'package:stellar_track/widgets/shimmer_loader.dart';

import '../controllers.dart';
import '../main.dart';
import '../widgets/signup_flow_button.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  dynamic data;
  final Controller c = Get.put(Controller());
  final co= TextEditingController();
  bool boolemail = false;
  bool boolgst = false;
  bool boolname = false;
  String new_name = "";
  String new_gst = "";
  String new_email = "";
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  bool cnf_pass_obs = true;
  bool pass_obs = true;

  @override
  void initState() {
    super.initState();
    getProfileDetails(c.refUserId.value).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double ht = MediaQuery.of(context).size.height;
    final double wd = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: wd / 8,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: ht / 23.8,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: SizedBox(
        //       height: ht / 14.5,
        //       child: BottomNavigation(
        //         height: ht / 14.5,
        //       )),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: data == null
            ? Center(child: ShimmerLoader(height: 60, width: wd))
            : data["data"] == null
            ? const Text("No Data Available")
            : SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            "       My Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5C5C5C),
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GestureDetector(
                            onTap: (){
                              c.screenIndex.value = 1;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()
                              )
                              );
                            },
                            child: Image.asset(
                              "assets/icons/icons_png/004-headphones.png",
                              color: const Color(0xff38456C),
                              width: wd / 10,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: !boolname,
                              child: Text(
                                new_name == "" ? data["data"][0]["first_name"].toString() : new_name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Visibility(
                              visible: boolname,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: SizedBox(
                                  height: 20,
                                  child: TextFormField(
                                    autofocus: true,
                                    enabled: true,
                                    onChanged: (value){
                                      setState(() {
                                        new_name = value;
                                      });
                                    },
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                    ),
                                    initialValue: data["data"][0]["first_name"].toString(),
                                    decoration: const InputDecoration(
                                        hintText : "Enter you new name",
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                if(boolname){
                                  updateProfileDetails(
                                      c.refUserId.value,
                                      new_name == "" ? data["data"][0]["first_name"].toString() : new_name,
                                      new_email == "" ? data["data"][0]["email"].toString() : new_email,
                                      new_gst == "" ? data["data"][0]["gst"].toString() : new_gst
                                  ).then((value) {
                                    setState(() {
                                      boolname = false;
                                      Get.showSnackbar(const GetSnackBar(
                                        duration: Duration(seconds: 2),
                                        message: "User Name Updated",
                                      ));
                                    });
                                  });
                                }
                                setState(() {
                                  boolname = true;
                                });
                              },
                              child: Align(
                                alignment : Alignment.centerRight,
                                child: Text(
                                  boolname ? 'Save' : 'Update',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: !boolemail,
                              child: Text(
                                new_email == "" ? data["data"][0]["email"].toString() : new_email,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Visibility(
                              visible: boolemail,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: SizedBox(
                                  height: 20,
                                  child: TextFormField(
                                    autofocus: true,
                                    enabled: true,
                                    onChanged: (value){
                                      setState(() {
                                        new_email = value;
                                      });
                                    },
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                    initialValue: data["data"][0]["email"].toString(),
                                    decoration: const InputDecoration(
                                        hintText : "Enter you new Email",
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                if(boolemail){
                                  updateProfileDetails(
                                      c.refUserId.value,
                                      new_name == "" ? data["data"][0]["first_name"].toString() : new_name,
                                      new_email == "" ? data["data"][0]["email"].toString() : new_email,
                                      new_gst == "" ? data["data"][0]["gst"].toString() : new_gst
                                  ).then((value) {
                                    setState(() {
                                      boolemail = false;
                                      Get.showSnackbar(const GetSnackBar(
                                        duration: Duration(seconds: 2),
                                        message: "User Email Updated",
                                      ));
                                    });
                                  });
                                }
                                setState(() {
                                  boolemail = true;
                                });
                              },
                              child: Align(
                                alignment : Alignment.centerRight,
                                child: Text(
                                  boolemail ? 'Save' : 'Update',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: !boolgst,
                              child: Text(
                                new_gst == "" ? data["data"][0]["gst"].toString() : new_gst,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Visibility(
                              visible: boolgst,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: SizedBox(
                                  height: 20,
                                  child: TextFormField(
                                    maxLength: 15,
                                    autofocus: true,
                                    enabled: true,
                                    onChanged: (value){
                                      setState(() {
                                        print("GST Entered is $new_gst");
                                        new_gst = value;
                                      });
                                    },
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                    initialValue: data["data"][0]["gst"].toString(),
                                    decoration: const InputDecoration(
                                        hintText : "Enter you new GST IN.",
                                        border: InputBorder.none,
                                        counterText: ""
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                if(boolgst){
                                  print("Api Called");
                                  updateProfileDetails(
                                      c.refUserId.value,
                                      new_name == "" ? data["data"][0]["first_name"].toString() : new_name,
                                      new_email == "" ? data["data"][0]["email"].toString() : new_email,
                                      new_gst == "" ? data["data"][0]["gst"].toString() : new_gst
                                  ).then((value) {
                                    setState(() {
                                      boolgst=false;
                                      Get.showSnackbar(const GetSnackBar(
                                        duration: Duration(seconds: 2),
                                        message: "User GST Updated",
                                      ));
                                    });
                                  });
                                }
                                setState(() {
                                  boolgst = true;
                                });
                              },
                              child: Align(
                                alignment : Alignment.centerRight,
                                child: Text(
                                  boolgst ? 'Save' : 'Update',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(context: context, builder:(BuildContext context){
                            return StatefulBuilder(builder: (context,setState){
                              {
                                return Dialog(
                                  child: SizedBox(
                                    height: ht / 2,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment:Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                            child: GestureDetector(
                                              onTap: (){
                                                Get.back();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff1FD0C2),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.white,

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Text(
                                                "Change Password",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff38456C)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: ht / 70, horizontal: ht / 60),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                elevation: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.cyan[50],
                                                  ),
                                                  child: Padding(
                                                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                        child: TextFormField(
                                                          textAlign: TextAlign.start,
                                                          keyboardType: TextInputType.text,
                                                          obscureText: pass_obs,
                                                          controller: password,
                                                          cursorColor: const Color(0xff38456C),
                                                          decoration: InputDecoration(
                                                              hintText: "Enter Password",
                                                              counterText: "",
                                                              border: InputBorder.none,

                                                              iconColor: Colors.white,
                                                              suffixIcon: IconButton(
                                                                icon:Icon(
                                                                  pass_obs ? Icons.visibility : Icons.visibility_off,
                                                                ),
                                                                onPressed: (){
                                                                  setState(() {
                                                                    pass_obs = !pass_obs;
                                                                  });
                                                                },
                                                              ),
                                                              focusColor: Colors.white,
                                                              fillColor: Colors.white),
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: ht / 60),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                elevation: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.cyan[50],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                    child: TextFormField(
                                                      textAlign: TextAlign.start,
                                                      keyboardType: TextInputType.visiblePassword,
                                                      controller: confirm_password,
                                                      cursorColor: const Color(0xff38456C),
                                                      obscureText: cnf_pass_obs,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter Confirm Password",
                                                          counterText: "",
                                                          border: InputBorder.none,
                                                          iconColor: Colors.white,
                                                          suffixIcon: IconButton(
                                                            icon: Icon(
                                                              cnf_pass_obs ? Icons.visibility : Icons.visibility_off,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                cnf_pass_obs = !cnf_pass_obs;
                                                              });
                                                            },
                                                          ),
                                                          focusColor: Colors.white,
                                                          fillColor: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SignUpFlowButton(
                                              buttonText:
                                              "Change Password ",
                                              textColor: Colors.black,
                                              onPressed: () {
                                                if (password.text == "") {
                                                  Get.showSnackbar(const GetSnackBar(
                                                    title: "Field Missing",
                                                    message: "Please enter password",
                                                    duration: Duration(seconds: 2),
                                                  ));
                                                }else if(confirm_password.text != password.text){
                                                  Get.showSnackbar(const GetSnackBar(
                                                    title: "Password not matched",
                                                    message: "Please enter same password and confirm password",
                                                    duration: Duration(seconds: 2),
                                                  ));
                                                } else {
                                                  updatePassword(c.refUserId.value, password.text.toString()).then((value) {
                                                    Get.back();
                                                    setState(() {
                                                      Get.showSnackbar(const GetSnackBar(
                                                        title: "Password Changed",
                                                        message: "Password changed successfully",
                                                        duration: Duration(seconds: 2),
                                                      ));
                                                    });

                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            });
                          }
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Change Password',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: GestureDetector(
                        onTap: (){
                           setState(() {
                             c.refUserId.value = "";
                             c.screenIndex.value = 0;
                             c.cartCount.value = 0;
                             getStorage.write('refUserId', null);
                             Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (context) =>
                                 const HomeScreen()
                             )
                             );
                           });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Sign out',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

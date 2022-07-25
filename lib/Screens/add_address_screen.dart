import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stellar_track/controllers.dart';
import 'package:stellar_track/functions.dart';
import 'package:stellar_track/widgets/select_address_type.dart';
import 'package:stellar_track/widgets/serviceButton.dart';
import 'package:stellar_track/widgets/shimmerLoader.dart';

import '../apiCalls.dart';
import '../main.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  void initState() {
    saveAddress().then((value) {
      log(value.toString());
      setState(() {
        c.address.value = value;
      });
    });

    super.initState();
  }

  Future updateAddress() async {
    var userAdderss;
    List addressMap = [];
    await determinePosition().then((value) {
      log("lat long ===>" + value.toString());
      setState(() {
        userAdderss = value;
      });
    });
    List splittedAdd = userAdderss[0].toString().split(',');
    for (var element in splittedAdd) {
      addressMap.add(element.toString().split(':')[1]);
    }
    // log("Mapped" + addressMap.toString());
    // log("Splitted address" + splitted_add.toString());
    // log("User address =>" + addressMap.toString());
    // log("User address =>" + userAdderss[0].toString());
    log("address Map " + addressMap.toString());
    return addressMap;
  }

  Future saveAddress() async {
    Map<String, String> add = {
      "Address": "",
      "Street_Name": "",
      "Sub_locality": "",
      "Locality": '',
      "City": '',
      "State": '',
      "Postal_code": '',
      "Country": ''
    };
    await updateAddress().then((value) {
      setState(() {
        add["Address"] = value[0] == " " ? "Address" : value[0].trim();
        add["Street_Name"] = value[1] == " " ? "Street name" : value[1].trim();
        add["Sub_locality"] =
            value[8] == " " ? "Sub locality" : value[8].trim();
        add["Locality"] = value[7] == " " ? "Locality" : value[7].trim();
        add["City"] = value[6] == " " ? "City" : value[6].trim();
        add["State"] = value[5] == " " ? "State" : value[5].trim();
        add["Postal_code"] = value[4] == " " ? "Postal Code" : value[4].trim();
        add["Country"] = value[3] == " " ? "Country" : value[3].trim();
      });
    });
// log(add.)
    return add;
  }

  final Controller c = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;

    addAddressDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return SafeArea(
                child: Dialog(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    color: Colors.white,
                    height: ht / 2,
                    width: wd / 1.25,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: wd / 8),
                              child: const Text(
                                "Tag your Address",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                      "assets/icons/icons_png/001-pin.png")),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: wd / 30),
                              child: SizedBox(
                                width: wd,
                                child: Text(
                                  // add["Address"],
                                  "${c.address["Address"]}, ${c.address["Sub_locality"]},${c.address["City"]},${c.address["State"]},${c.address["Country"]},${c.address["Postal_code"]}",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  maxLines: 4,
                                  // overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: wd / 8),
                              child: SizedBox(
                                  width: wd / 1.5,
                                  child: const SelectAddressType()),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: wd / 20),
                              child: ServiceButton(
                                  onTap: () async {
                                    await saveUserAddress(
                                      c.refUserId.value,
                                      c.addressType.value,
                                      c.address["State"],
                                      c.address["City"],
                                      c.address["Postal_code"],
                                      c.coordinates["lat"],
                                      c.coordinates["lng"],
                                      c.address["Address"],
                                    );
                                    Get.offAll(const HomeScreen());
                                  },
                                  fontSize: 16,
                                  height: 40,
                                  width: wd / 4,
                                  buttonText: "OK"),
                            )
                          ]),
                    ),
                  ),
                ),
              );
            });
          });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff38456C),
      body: SafeArea(
        child: Obx((() => SizedBox(
              height: ht,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: ht / 1.8,
                        child: Image.asset(
                          "assets/housewife-woking-home-lady-blue-shirt-woman-bathroom.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Text(
                        "Current Location",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  c.address["Address"] != null
                      ? Center(
                          child: SizedBox(
                            width: wd,
                            child: Text(
                              // add["Address"],
                              "${c.address["Address"]}, ${c.address["Sub_locality"]},${c.address["Locality"]},${c.address["State"]},${c.address["Country"]},${c.address["Postal_code"]}",
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                              maxLines: 4,
                              // overflow: TextOverflow.visible,
                            ),
                          ),
                        )
                      : LocationShimmer(
                          height: wd / 10,
                          width: wd / 2,
                          string: "Fetching location",
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: addAddressDialog,
                        child: const Text(
                          "ADD",
                          style:
                              TextStyle(color: Color(0xff1FD0C2), fontSize: 16),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "CHANGE",
                          style:
                              TextStyle(color: Color(0xff1FD0C2), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: wd / 15, vertical: ht / 50),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "SKIP",
                          style:
                              TextStyle(color: Color(0xff1FD0C2), fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))),
      ),
    );
  }
}

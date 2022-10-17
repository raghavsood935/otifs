import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stellar_track/widgets/loader.dart';

import '../api_calls.dart';
import '../controllers.dart';
import '../functions.dart';
import '../main.dart';
import '../models.dart';
import '../widgets/service_button.dart';
var first_time_coupn;
class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {required this.data,
      required this.isCart,
      required this.isBottomNav,
      Key? key, required this.unit_values_id, required this.total_amount, this.quantity})
      : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
  final dynamic data;
  final int unit_values_id;
  final bool isCart;
  final bool isBottomNav;
  final String total_amount;
  final String? quantity;
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPaymentMode = 'Cash on Delivery';
  String paymentModeCode = 'cash';
  String email = "";
  String phone = "";
  dynamic pricedata;

  int? currentModeSelected = 0;
  final Controller c = Get.put(Controller());
  TextEditingController emailController = TextEditingController(text: "email");
  TextEditingController phoneController = TextEditingController(text: "phone");
  @override
  void initState() {
    getProfileDetails(c.refUserId.value).then((value) {
      setState(() {
        c.email.value = value["data"][0]["email"].toString();
        c.mobile.value = value["data"][0]["mobile"].toString();
        emailController.text = value["data"][0]["email"].toString();
        phoneController.text = value["data"][0]["mobile"].toString();
      });
    });
    getfirstcoupon(c.refUserId.value).then((value){
      setState(() {
        first_time_coupn = value;
        print(widget.quantity.toString());
        calculateprcie(
            c.refUserId.value,
            widget.isCart == false ? "book_one_time" : "",
            first_time_coupn["status"] != "failure" ? first_time_coupn["data"]["coupon_id"] : "0",
            widget.unit_values_id,
            widget.data["product_id"],
            widget.quantity.toString()
        ).then((value) {
              pricedata = value;
        });
      });
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    var ht = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 40,
        leading: Padding(
          padding: EdgeInsets.only(left: wd / 60.0),
          child: Container(
            // height: ht / 10,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Card(
                shape: CircleBorder(),
                elevation: 3,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: wd / 6.0),
            child: GestureDetector(
              onTap: (){
                c.screenIndex.value = 1;
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()
                )
                );
              },
              child: Image.asset(
                "assets/AppBarCall.png",
                width: 20,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ht / 1.4,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: wd,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: wd / 15),
                                  child: const Text(
                                    "Complete Payment",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Color(0xff38456C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  // "10 May, 9 AM",
                                  '${DateTime.parse(c.dateSelected.value).add(Duration(days: 0))
                                      .toString().split('-')[2]
                                      .split(' ')
                                      .first
                                  } ${monthMap[
                                  DateTime.parse(c.dateSelected.value)
                                      .toString().split('-')[1].toString()
                                  ]},'
                                      '${c.timeSlot.value}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff1FD0C2),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400
                              ),
                            ),
                          ),
                        ),
                        widget.isCart == true
                            ? Container()
                            : SizedBox(
                                width: wd ,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "Amount",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff38456C),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "₹"+pricedata['data']["amount"].toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff38456C),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "GST Amount",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff38456C),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "₹"+pricedata['data']["gst_amount"].toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff38456C),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          first_time_coupn["status"] != "failure" ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Discount Amount",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff38456C),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "₹"+pricedata["data"]["coupon_amount"].toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff38456C),
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ):Container(),
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                          child: Container(
                                            height: 1,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400
                                            ),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total Amount",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xff1FD0C2),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "₹"+pricedata['data']["total_amount"].toString(),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xff1FD0C2),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                              )
                      ],
                    ),
                    //Referal or Coupon code ROW
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(context: context, builder:(BuildContext context){
                            return StatefulBuilder(builder: (context,setState){
                              {
                                return Dialog(
                                  child: SizedBox(
                                    height: ht / 3,
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
                                                    color: Color(0xff1FD0C2),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5),
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
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                              child: Text(
                                                "Enter Coupon Code",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff38456C)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: ht / 70, horizontal: ht / 60),
                                              child: Stack(
                                                children: [
                                                  Card(
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
                                                          cursorColor: const Color(0xff38456C),
                                                          decoration: InputDecoration(
                                                              hintText: "Enter Coupon Code",
                                                              counterText: "",
                                                              border: InputBorder.none,
                                                              iconColor: Colors.white,
                                                              focusColor: Colors.white,
                                                              fillColor: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:Alignment.centerRight,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 12, 15, 0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(7),
                                                          color: Color(0xff1FD0C2),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 5,10, 5),
                                                          child: Text("APPLY",
                                                            style: TextStyle(
                                                              color: Colors.white
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                                    child: Text(
                                                      "Available Coupons",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(0xff38456C)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          first_time_coupn["data"]["coupon_code"],
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color(0xff38456C)),
                                                        ),
                                                        Text(
                                                          '   Click to apply',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color(0xff1FD0C2)
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                        child: Card(
                          shadowColor: const Color(0xff000029),
                          elevation: 5,
                          margin: const EdgeInsets.all(0),
                          child: Container(
                            height: ht / 12,
                            width: wd,
                            color: const Color(0xffF7F7F7),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.wallet_giftcard_outlined,
                                    size: 27,
                                    color: Color(0xff38456C),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      "Select coupon code or rewards",
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C), fontSize: 18),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.arrow_right)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Product Details
                    widget.isCart == false
                        ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Container(
                              height: ht / 8,
                              width: wd,
                              color: const Color(0xffF7F7F7),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    shape: const CircleBorder(),
                                    elevation: 10,
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      width: ht / 10,
                                      child: Image.network(
                                          widget.data["product_image"]),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.data["product_name"],
                                          style: const TextStyle(
                                              color: Color(0xff5C5C5C),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: wd / 50),
                                          child: Text(
                                              widget.data["product_summary"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Color(0xff7E7D7D),
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                        )
                        : SizedBox(
                            width: wd,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: wd / 20, horizontal: wd / 15),
                                  child: const Text(
                                    'View cart',
                                    style: TextStyle(
                                        color: Color(0xff38456C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Fill Payment Details",
                                  style: TextStyle(
                                      color: Color(0xff5C5C5C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.arrow_right)),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: ht / 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: wd / 1.5,
                                        child: const Text(
                                          "Please enter your E-mail ID and contact details to confirm booking",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: wd / 1.5, height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffE5E5E5),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    // height: ,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          hintText: "Email",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: wd / 1.5,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffE5E5E5),
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      // height: ,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        maxLength: 10,
                                        controller: phoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                            hintText: "Phone no.",
                                            border: InputBorder.none,
                                            counterText: ""),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Select Payment Method",
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.arrow_right)),
                                  ],
                                ),
                                Obx(
                                  () => ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: c.paymentMethods.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                              onTap: () {
                                                setState(() {
                                                  currentModeSelected = index;
                                                  selectedPaymentMode =
                                                      c.paymentMethods[index];
                                                  paymentModeCode =
                                                      c.paymentMethodCodes[
                                                          index];
                                                });
                                               
                                              },
                                              title: Text(
                                                c.paymentMethods[index]
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              trailing: Icon(
                                                Icons.check_circle,
                                                color:
                                                    currentModeSelected == index
                                                        ? Colors.lightGreen
                                                        : Colors.grey,
                                              )),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
             Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: ServiceButton(
                    fontSize: 14,
                    width: wd / 2,
                    buttonText: "Confirm Booking",
                    onTap: () async {
                      if (widget.isCart == false) {
                        if (emailController.text == "" ||
                            phoneController.text == "" ||
                            selectedPaymentMode == "" ||
                            c.addressID.value == "") {
                          Get.showSnackbar(GetSnackBar(
                            duration: const Duration(seconds: 2),
                            message: c.addressID.value == ""
                                ? "Please save an address"
                                : "Please fill all the fields",
                          ));
                        } else {
                          Get.dialog(const Loader());
                          await savePhoneAndEmail(
                              emailController.text, phoneController.text);
                          await booking(
                                  c.refUserId.value,
                                  c.addressID.value,
                                  widget.data['product_id'],
                                  widget.data["unit_name"],
                                  widget.unit_values_id.toString(),
                                  c.sqft.value,
                                  c.dateSelected.value,
                                  c.dateSelected.value,
                                  paymentModeCode,
                                  c.timeSlot.value,
                                  c.totime.value,
                                  c.mobile.value,
                                  c.email.value)
                              .then((value) {
                            if (value["response"]["type"] == "save_success") {
                              Get.back();
                              Get.showSnackbar(const GetSnackBar(
                                message: "Service Booked",
                              ));
                              Get.offAll(const HomeScreen());
                              // Navigator.popUntil(
                              //     context,
                              //    );
                            } else {
                              Get.back();
                              Get.dialog(
                                Dialog(
                                    child: SizedBox(
                                        child: Text(
                                            '${value['response']['message']}'))),
                              );
                            }
                          });
                        }
                      } else {
                        if (emailController.text == "" ||
                            phoneController.text == "" ||
                            selectedPaymentMode == "") {
                          Get.showSnackbar(const GetSnackBar(
                            duration: Duration(seconds: 2),
                            message: "Please fill all the fields",
                          ));
                        } else {
                          Get.dialog(const Loader());
                          await savePhoneAndEmail(
                                  emailController.text, phoneController.text)
                              .then((value) async {
                            await cartbooking(
                                    c.refUserId.value,
                                    c.addressID.value,
                                    paymentModeCode,
                                    phoneController.text,
                                    emailController.text)
                                .then(
                              (value) async {
                                if (widget.isBottomNav == true) {
                                  await updateCartCount(setState, c);
                                  Get.close(2);
                                  setState(() {
                                    c.screenIndex.value = 0;
                                  });
                                } else {
                                  await updateCartCount(setState, c);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const HomeScreen()));
                                }

                                Get.snackbar(
                                    "ATTENTION", value['response']['message']);
                              },
                            );
                          });
                        }
                      }
                    }),
              ),

          ],
        ),
      ),
    );
  }
}

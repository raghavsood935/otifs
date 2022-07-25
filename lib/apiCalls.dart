import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'controllers.dart';

// fetches list of
Future getData() async {
  var request = http.Request(
      'GET', Uri.parse('https://www.otifs.com/api/b2c/services/list'));

  http.StreamedResponse response = await request.send();
  var data = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(data);
  } else {
    print(response.reasonPhrase);
  }
  return data;
}

//Fetches the list of services after adding main and sub-category
Future getServices(var mainCatId, var subCatId) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/services/list?main_category_id=$mainCatId&sub_category_id=$subCatId'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

// Fetches product details
Future getProductDetails(prodID) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/services/details?product_id=$prodID'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

//Fetches the seasonal offers
Future getSeasonalOffers() async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/home-page/season-offers'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

//Fetches the ongoing offers
Future getOngoingOffers() async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/home-page/on-going-offers'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

// Triggers the otp after entering mobile number
Future getOtp(String phone) async {
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/auth/signin/otp/send?phone=$phone'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

//Validates the otp entered
Future validateOTP(String phone, String otp) async {
  final Controller c = Get.put(Controller());
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/auth/signin/otp/confirm?phone=$phone&otp=$otp'));
// https://otifs.com/stage/public/api/hybrid/auth/signin/otp/confirm?phone=$phone&otp=$otp
  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    log(res.toString() + res["data"]["ref_user_id"].toString());
    c.refUserId.value = res["data"]["ref_user_id"].toString();
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

//Fetches the main categories
Future getMainCategories() async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/home-page/main-category'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

// Fetches the sub categories after entering the main category id
Future getSubcategories(String catId) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/home-page/sub-category?main_category_id=$catId&sub_category_id'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }

  return res;
}

//Fetches popular services
Future getPopularServices() async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/home-page/popular-services?'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

//Fetches Banners being displayed on the home screen
Future getHomeBanners() async {
  var request = http.Request('GET',
      Uri.parse('https://otifs.com/stage/public/api/hybrid/home-page/banner'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

Future getMainAndSubCategories() async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/home-page/main-sub-category'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print("Sub categories===> " + res.toString());
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

Future saveUserAddress(userID, addressType, stateName, cityName, pinCode, lat,
    lng, address1) async {
  log("$userID , $addressType , $stateName , $cityName , $pinCode , $lat , $lng , $address1 ");
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/auth/profile/address/store?ref_user_id=$userID&address_type=$addressType&state_name=$stateName&city_name=$cityName&latitude=$lat&longitude=$lng&address1=$address1&pincode=$pinCode'));
  // 'https://otifs.com/stage/public/api/hybrid/auth/profile/address/store?ref_user_id=$userID&address_type=$addressType&state_name=$stateName&city_name=$cityName&pincode=$pinCode&latitude=$lat&longitude=$lng&address1=$address1'));
  //    https://otifs.com/stage/public/api/hybrid/auth/profile/address/store?ref_user_id=$userID&address_type=$addressType&state_name=$stateName&city_name=$cityName&latitude=$lat&longitude=$lng&address1=$address1&&pincode=$pincode
  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
}

//Get Product Time SLots

Future getProductTimeSlots() async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/services/slots?product_id=193'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

//get Time slots
Future getTimeSlots(prodID) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/services/slots?product_id=$prodID'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

Future booking(refUserID, addID, prodID, unitName, unitID, qty, fromDate,
    toDate, payMode, fromTime, toTime, phone, email) async {
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/services/booking?ref_user_id=$refUserID&address_id=$addID&product_id=$prodID&unit_name=$unitName&unit_id=$unitID&quantity=$qty&from_date=$fromDate&to_date=$toDate&payment_mode=$payMode&from_time=$fromTime&to_time=$toTime&contact_phone=$phone&contact_email=$email'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

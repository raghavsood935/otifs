import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

getOtp(String phone) async {
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
}

Future validateOTP(String phone, String otp) async {
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://otifs.com/stage/public/api/hybrid/auth/signin/otp/confirm?phone=$phone&otp=$otp'));

  http.StreamedResponse response = await request.send();
  var res = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(res);
  } else {
    print(response.reasonPhrase);
  }
  return res;
}

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

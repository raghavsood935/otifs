import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'controllers.dart';

Future determinePosition() async {
  // GeoCode geoCode = GeoCode();
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  var location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
//  var address = location;
  final Controller c = Get.put(Controller());

  c.coordinates["lat"] = location.latitude.toString();
  c.coordinates["lng"] = location.longitude.toString();

  List<dynamic> address = await placemarkFromCoordinates(
    location.latitude,
    location.longitude,
  );
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return address;
}

savePhoneAndEmail(email, mobile) {
  final Controller c = Get.put(Controller());
  c.email.value = email.toString();
  c.mobile.value = mobile.toString();
}

Future getDateTime() async {
  DateTime dateToday = DateTime.now();

  String date = dateToday.toString().substring(0, 10);
  // log("Weekday ${dateToday.weekday}"); //
  return dateToday;
}

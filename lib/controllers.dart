import 'package:get/get.dart';

class Controller extends GetxController {
  RxString refUserId = ''.obs;
  dynamic otpField = false.obs;
  RxString mobile = ''.obs;
  RxString email = ''.obs;
  RxMap<String, String> address = {"": ""}.obs;
  RxMap<String, String> coordinates = {"lat": "", "lng": ""}.obs;
  RxString addressType = 'H'.obs;
  RxString sqft = ''.obs;
  RxString dateSelected = ''.obs;
  RxString timeSlot = ''.obs;
  RxString currentTimeSelected = ''.obs;
  RxString currentDateSelected = ''.obs;
  RxString date = "".obs;
  RxString weekday = "0".obs;
}

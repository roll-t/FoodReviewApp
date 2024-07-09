import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantChangeInfoController extends GetxController {
  final Rx<TimeOfDay> selectedTimeOnl = TimeOfDay(hour: 7, minute: 0).obs;

  Future<void> selectTimeOnline(BuildContext context) async {
    final selectedTime = await showTimePicker(
        context: context,
        initialTime: selectedTimeOnl.value,
        initialEntryMode: TimePickerEntryMode.input);
    print('selectedTime: $selectedTime');
    if (selectedTime != null) {
      selectedTimeOnl.value = selectedTime;
    }
  }
}

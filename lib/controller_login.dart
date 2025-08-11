import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/doctor_screens/doctor_first_screen.dart';
import 'package:hospital_management/staff_screen/staff_first_screen.dart';

class ControllerLogin extends GetxController {
  late TextEditingController textEditingControllerPhoneNumber;
  late TextEditingController textEditingControllerPassword;

  @override
  void onInit() {
    super.onInit();
    textEditingControllerPhoneNumber = TextEditingController();
    textEditingControllerPassword = TextEditingController();
  }

  void performLogin() {
    final phone = textEditingControllerPhoneNumber.text.trim();
    final password = textEditingControllerPassword.text.trim();

    // Check credentials
    if (phone == "1234" && password == "staff") {
      Get.snackbar(
        "Login Successful",
        "Welcome back!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => StaffFirstScreen());
    } else if (phone == "1234" && password == "doctor") {
      Get.snackbar(
        "Login Success",
        "Welcome Sir",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => DoctorFirstScreen());
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid phone or password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    textEditingControllerPhoneNumber.dispose();
    textEditingControllerPassword.dispose();
    super.onClose();
  }
}

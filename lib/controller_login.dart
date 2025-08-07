import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ControllerLogin extends GetxController {
  late TextEditingController textEditingControllerPhoneNumber;
  late TextEditingController textEditingControllerPassword;

  @override
  void onInit() {
    super.onInit();

    textEditingControllerPhoneNumber = TextEditingController();
    textEditingControllerPassword = TextEditingController();
  }

  @override
  void onClose() {
    textEditingControllerPhoneNumber.dispose();
    textEditingControllerPassword.dispose();
    super.onClose();
  }
}

import 'package:get/get.dart';
import 'package:hospital_management/login_screen.dart';

class ControllerLoading extends GetxController {
  @override
  void onInit() {
    redirectAfter2sec();
    super.onInit();
  }

  void redirectAfter2sec() {
    Future.delayed(Duration(seconds: 2), () {
      Get.off(LoginScreen());
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DoctorController extends GetxController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController degreeController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  var selectedGender = ''.obs;
  var isActive = true.obs;

  final genders = ['Male', 'Female'];

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    degreeController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  void toggleActiveStatus(bool status) {
    isActive.value = status;
  }

  void selectStartTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    startTimeController.text = DateFormat('h:mm a').format(dateTime);
  }

  void selectEndTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    endTimeController.text = DateFormat('h:mm a').format(dateTime);
  }

  Future<void> insertDoctor({required Database db}) async {
    try {
      String currentDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

      String query = '''
    INSERT INTO doctor (
      first_name,
      last_name,
      degree,
      start_time,
      end_time,
      gender,
      is_active,
      created_date
    ) VALUES (
      '${firstNameController.text.trim()}',
      '${lastNameController.text.trim()}',
      '${degreeController.text.trim()}',
      '${startTimeController.text.trim()}',
      '${endTimeController.text.trim()}',
      '${selectedGender.value}',
      ${isActive.value ? 1 : 0},
      '$currentDate'
    );
  ''';

      await db.rawInsert(query);
      debugPrint("Doctor inserted successfully.");
    } catch (e) {
      debugPrint("Error inserting doctor: $e");
    }
  }

  void saveDoctorInfo() async {
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        degreeController.text.trim().isEmpty ||
        startTimeController.text.trim().isEmpty ||
        endTimeController.text.trim().isEmpty ||
        selectedGender.value.isEmpty) {
      Get.snackbar(
        "Missing Information",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      Database db = Get.find();
      await insertDoctor(db: db);

      Get.snackbar(
        "Doctor Information Saved",
        "Doctor details have been saved successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Future.delayed(Duration(seconds: 1), () {
        Get.back();
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save doctor information: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    degreeController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.onClose();
  }
}

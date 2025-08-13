import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class AppointmentFormController extends GetxController {
  late TextEditingController patientNameController;
  late TextEditingController doctorNameController;

  var selectedVisitType = ''.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTimeSlot = ''.obs;

  Database db = Get.find();

  final visitTypes = ['New Visit', 'Follow-up', 'Urgent', 'Consultation'];

  final timeSlots = [
    '12:00 AM', '1:00 AM', '2:00 AM', '3:00 AM', '4:00 AM', '5:00 AM',
    '6:00 AM', '7:00 AM', '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM',
    '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM',
    '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM'
  ];

  @override
  void onInit() {
    super.onInit();
    patientNameController = TextEditingController();
    doctorNameController = TextEditingController();
  }

  void selectVisitType(String visitType) {
    selectedVisitType.value = visitType;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlot.value = timeSlot;
  }

  Future<void> insertAppointment() async {
    try {
      String currentDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
      String appointmentDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);

      String query = '''
        INSERT INTO appointments (
          doctor_name,
          visit_type,
          appointment_date,
          appointment_time,
          status,
          created_date
        ) VALUES (
          '${doctorNameController.text.trim()}',
          '${selectedVisitType.value.trim()}',
          '$appointmentDate',
          '${selectedTimeSlot.value.trim()}',
          'Scheduled',
          '$currentDate'
        );
      ''';

      await db.rawInsert(query);

      Get.snackbar(
        "Success",
        "Appointment scheduled successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to schedule appointment",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void scheduleAppointment() {
    if (doctorNameController.text.trim().isEmpty ||
        patientNameController.text.trim().isEmpty ||
        selectedVisitType.value.isEmpty ||
        selectedTimeSlot.value.isEmpty) {
      Get.snackbar(
        "Missing Information",
        "Please fill all fields",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    insertAppointment();
  }

  @override
  void onClose() {
    patientNameController.dispose();
    doctorNameController.dispose();
    super.onClose();
  }
}

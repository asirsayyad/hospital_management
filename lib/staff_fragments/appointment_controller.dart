import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class AppointmentController extends GetxController {
  var selectedDoctor = ''.obs;
  var selectedVisitType = ''.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTimeSlot = ''.obs;

  Database db = Get.find(); // Database instance from GetX

  final doctors = [
    'Dr. Smith - Cardiologist',
    'Dr. Johnson - Neurologist',
    'Dr. Brown - Pediatrician',
    'Dr. Davis - Orthopedic',
    'Dr. Wilson - Dermatologist'
  ];

  final visitTypes = [
    'New Visit',
    'Follow-up',
    'Urgent',
    'Consultation'
  ];

  final timeSlots = [
    '12:00 AM',
    '1:00 AM',
    '2:00 AM',
    '3:00 AM',
    '4:00 AM',
    '5:00 AM',
    '6:00 AM',
    '7:00 AM',
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
    '9:00 PM',
    '10:00 PM',
    '11:00 PM'
  ];

  void selectDoctor(String doctor) {
    selectedDoctor.value = doctor;
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

  // Database insertion method
  Future<void> insertAppointment() async {
    try {
      String currentDate = DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now());
      String appointmentDate = DateFormat('dd MMMM yyyy').format(selectedDate.value);

      String query = '''
        INSERT INTO appointments (
          doctor_name,
          visit_type,
          appointment_date,
          appointment_time,
          status,
          created_date
        ) VALUES (
          '${selectedDoctor.value.trim()}',
          '${selectedVisitType.value.trim()}',
          '$appointmentDate',
          '${selectedTimeSlot.value.trim()}',
          'Scheduled',
          '$currentDate'
        );
      ''';

      await db.rawInsert(query);
      debugPrint("Appointment inserted successfully.");

      Get.snackbar(
        "Appointment Scheduled",
        "Your appointment has been scheduled successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate back after successful scheduling
      Get.back();

    } catch (e) {
      debugPrint("Error inserting appointment: $e");

      Get.snackbar(
        "Error",
        "Failed to schedule appointment. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Updated scheduleAppointment method - now automatically saves to database
  void scheduleAppointment() {
    if (selectedDoctor.value.isEmpty ||
        selectedVisitType.value.isEmpty ||
        selectedTimeSlot.value.isEmpty) {
      Get.snackbar(
        "Missing Information",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Automatically insert into database
    insertAppointment();
  }
}

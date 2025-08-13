import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AppointmentListController extends GetxController {
  var searchText = ''.obs;
  var appointmentList = <Map<String, dynamic>>[].obs;
  var filteredAppointmentList = <Map<String, dynamic>>[].obs;
  Database db = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      List<Map<String, dynamic>> list = await db.rawQuery(
          "SELECT id, doctor_name, visit_type, appointment_date, appointment_time, status FROM appointments ORDER BY appointment_date DESC"
      );
      appointmentList.value = list;
      filteredAppointmentList.value = List.from(list);
    } catch (e) {
      debugPrint("DB Error: $e");
    }
  }

  Future<void> updateSearch(String query) async {
    final lowerCaseQuery = query.toLowerCase();

    final results = appointmentList.where((item) {
      final doctorName = item['doctor_name']?.toString().toLowerCase() ?? '';
      final visitType = item['visit_type']?.toString().toLowerCase() ?? '';
      final status = item['status']?.toString().toLowerCase() ?? '';
      return doctorName.contains(lowerCaseQuery) ||
          visitType.contains(lowerCaseQuery) ||
          status.contains(lowerCaseQuery);
    }).toList();

    filteredAppointmentList.value = results;
  }

  /// Deletes an appointment from DB and updates lists
  Future<void> deleteAppointment(dynamic appointmentId) async {
    try {
      int id = appointmentId is int ? appointmentId : int.tryParse('$appointmentId') ?? 0;

      if (id <= 0) {
        debugPrint("Invalid appointment ID: $appointmentId");
        return;
      }

      int deletedRows = await db.delete(
        'appointments',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (deletedRows > 0) {
        appointmentList.removeWhere((appointment) => appointment['id'] == id);
        filteredAppointmentList.removeWhere((appointment) => appointment['id'] == id);

        debugPrint("Appointment deleted successfully");

        Get.snackbar(
          "Appointment Deleted",
          "Appointment has been removed successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        debugPrint("No appointment found with ID: $id");
      }
    } catch (e) {
      debugPrint("Error deleting appointment: $e");
      Get.snackbar(
        "Error",
        "Failed to delete appointment",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'in-progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

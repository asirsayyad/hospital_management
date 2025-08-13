import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class AppointmentListController extends GetxController {
  var searchText = ''.obs;
  var appointmentList = <Map<String, dynamic>>[].obs;
  var filteredAppointmentList = <Map<String, dynamic>>[].obs;
  var selectedDateText = ''.obs;
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

  void filterBySelectedDate(DateTime selectedDate) {
    String targetDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    selectedDateText.value = DateFormat('dd/MM/yyyy').format(selectedDate);

    final results = appointmentList.where((item) {
      final appointmentDate = item['appointment_date']?.toString() ?? '';
      return appointmentDate == targetDate;
    }).toList();

    filteredAppointmentList.value = results;
  }

  Future<void> updateSearch(String query) async {
    final lowerCaseQuery = query.toLowerCase();
    List<Map<String, dynamic>> searchList = appointmentList;

    final results = searchList.where((item) {
      final doctorName = item['doctor_name']?.toString().toLowerCase() ?? '';
      final visitType = item['visit_type']?.toString().toLowerCase() ?? '';
      final status = item['status']?.toString().toLowerCase() ?? '';
      return doctorName.contains(lowerCaseQuery) ||
          visitType.contains(lowerCaseQuery) ||
          status.contains(lowerCaseQuery);
    }).toList();

    if (selectedDateText.value.isNotEmpty) {
      final selectedDateFormatted = DateFormat('dd/MM/yyyy').parse(selectedDateText.value);
      String targetDate = DateFormat('yyyy-MM-dd').format(selectedDateFormatted);

      final dateFiltered = results.where((item) {
        final appointmentDate = item['appointment_date']?.toString() ?? '';
        return appointmentDate == targetDate;
      }).toList();

      filteredAppointmentList.value = dateFiltered;
    } else {
      filteredAppointmentList.value = results;
    }
  }

  Future<void> deleteAppointment(int appointmentId) async {
    try {
      await db.rawDelete("DELETE FROM appointments WHERE id = ?", [appointmentId]);

      // Always refresh from DB to ensure lists are in sync
      await fetchAppointments();

      // Reapply filters if needed
      if (selectedDateText.value.isNotEmpty) {
        final selectedDateFormatted = DateFormat('dd/MM/yyyy').parse(selectedDateText.value);
        filterBySelectedDate(selectedDateFormatted);
      } else if (searchText.value.isNotEmpty) {
        await updateSearch(searchText.value);
      }

      Get.snackbar("Success", "Appointment deleted",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Delete failed",
          backgroundColor: Colors.red, colorText: Colors.white);
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

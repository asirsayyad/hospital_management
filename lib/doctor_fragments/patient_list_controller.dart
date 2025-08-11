import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class patient_list_controller extends GetxController {
  var searchText = ''.obs;
  var selectedIndex = 0.obs;
  var rxPatientList = <Map<String, dynamic>>[].obs;
  var filteredPatientList = <Map<String, dynamic>>[].obs;
  var patientList = <Map<String, dynamic>>[].obs;
  Database db = Get.find();


  // staff_first_screen_controller.dart
  Future<List<Map<String, dynamic>>> fetchPatientHistory(int patientId) async {
    try {
      final result = await db.rawQuery(
        "SELECT visit_date, visit_time FROM visits WHERE patient_id = ? ORDER BY visit_date DESC",
        [patientId],
      );
      return result;
    } catch (e) {
      debugPrint("Error fetching patient history: $e");
      return [];
    }
  }


  Future<void> fetchPatientNames() async {
    try {
      // Fetch id too so we can delete rows
      List<Map<String, dynamic>> list = await db.rawQuery(
          "SELECT id, name, last_name, mobile_number FROM patient"
      );
      patientList.value = list;
      filteredPatientList.value = List.from(list);
    } catch (e) {
      debugPrint("DB Error: $e");
    }
  }





  Future<void> updateSearch(String query) async {
    final lowerCaseQuery = query.toLowerCase();

    final results = patientList.where((item) {
      final fullName =
      '${item['name']} ${item['last_name']}'.toLowerCase();
      final mobileNumber = item['mobile_number']?.toString().toLowerCase() ??
          '';
      return fullName.contains(lowerCaseQuery) ||
          mobileNumber.contains(lowerCaseQuery);
    }).toList();

    filteredPatientList.value = results;
  }

  Future<void> selectMenuItem(int index) async {
    selectedIndex.value = index;
  }

/// Deletes a patient from DB and updates lists/
}

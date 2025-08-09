import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class StaffFirstScreenController extends GetxController {
  var searchText = ''.obs;
  var selectedIndex = 0.obs;
  var rxPatientList = <Map<String, dynamic>>[].obs;
  var filteredPatientList = <Map<String, dynamic>>[].obs;
  var patientList = <Map<String, dynamic>>[].obs;
  Database db = Get.find();

  // Dummy JSON data
  var dummyData = [
    {"id": 1, "name": "John Doe", "type": "Patient", "date": "2025-08-08"},
    {"id": 2, "name": "Jane Smith", "type": "Appointment", "date": "2025-08-09"},
    {"id": 3, "name": "Bob Johnson", "type": "Patient", "date": "2025-08-10"},
    {"id": 4, "name": "Alice Brown", "type": "Appointment", "date": "2025-08-11"},
    {"id": 5, "name": "Charlie Wilson", "type": "Patient", "date": "2025-08-12"},
  ].obs;

  // void updateSearch(String value) {
  //   searchText.value = value;
  // }

  // void selectMenuItem(int index) {
  //   selectedIndex.value = index;
  // }

  Future<void> fetchPatientNames() async {
    try {
      List<Map<String, dynamic>> list = await db.rawQuery(
          "SELECT name, last_name FROM patient"
      );
      patientList.value = list;
      filteredPatientList.value = list; // initial copy for search
    } catch (e) {
      debugPrint("DB Error: $e");
    }
  }

  Future<void> updateSearch(String query) async {
    final results = patientList.where((item) {
      final fullName = '${item['name']} ${item['last_name']}'.toLowerCase();
      return fullName.contains(query.toLowerCase());
    }).toList();
    filteredPatientList.value = results;
  }

  Future<void> selectMenuItem(int index) async {
    // You can add logic to switch screen/tab if needed
    debugPrint("Selected menu item: $index");
  }
}



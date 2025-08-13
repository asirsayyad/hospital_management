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

  @override
  void onInit() {
    super.onInit();
    fetchPatientNames(); // Initialize data when controller is created
  }

  Future<void> fetchPatientNames() async {
    try {
      // Fetch id too so we can delete rows
      List<Map<String, dynamic>> list = await db.rawQuery(
          "SELECT id, name, last_name, mobile_number FROM patient LIMIT 50"
      );
      patientList.value = list;
      filteredPatientList.value = List.from(list);
    } catch (e) {
      debugPrint("DB Error: $e");
    }
  }

  // todo: pagination
  Future<void> updateSearch(String query) async {
    if(query.length > 2) {
      final lowerCaseQuery = query.toLowerCase().trim();
      var listPatient = await db.rawQuery("SELECT * FROM patient WHERE name LIKE '%$lowerCaseQuery%' OR last_name LIKE '%$lowerCaseQuery%' OR mobile_number LIKE '%$lowerCaseQuery%'");

      // final results = patientList.where((item) {
      //   final fullName =
      //   '${item['name']} ${item['last_name']}'.toLowerCase();
      //   final mobileNumber = item['mobile_number']?.toString().toLowerCase() ??
      //       '';
      //   return fullName.contains(lowerCaseQuery) ||
      //       mobileNumber.contains(lowerCaseQuery);
      // }).toList();

      filteredPatientList.value = listPatient;
    } else {
      fetchPatientNames();
    }
  }

  Future<void> selectMenuItem(int index) async {
    selectedIndex.value = index;
  }

/// Deletes a patient from DB and updates lists/
}

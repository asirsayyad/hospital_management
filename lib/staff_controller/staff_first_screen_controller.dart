import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    fetchPatientNames();
    // await deletePatient(int id);
  }
  Future<void> deletePatient(int id) async {
    try {
      // Delete from database
      int deletedCount = await db.delete(
        'patient', // Table name
        where: 'id = ?',
        whereArgs: [id],
      );

      if (deletedCount > 0) {
        debugPrint("Patient with id $id deleted successfully.");

        // ✅ Refresh list directly
        await fetchPatientNames();
      } else {
        debugPrint("No patient found with id $id.");
      }
    } catch (e) {
      debugPrint("Delete Error: $e");
    }
  }




  Future<void> fetchPatientNames() async {
    try {
      List<Map<String, dynamic>> list = await db.rawQuery(
        "SELECT id, name, last_name, mobile_number FROM patient LIMIT 50",
      );
      patientList.value = list;
      filteredPatientList.value = List.from(list);
    } catch (e) {
      debugPrint("DB Error: $e");
    }
  }

  Future<void> updateSearch(String query) async {
    if (query.length > 2) {
      final lowerCaseQuery = query.toLowerCase().trim();
      var listPatient = await db.rawQuery("""
        SELECT * FROM patient 
        WHERE name LIKE '%$lowerCaseQuery%' 
        OR last_name LIKE '%$lowerCaseQuery%' 
        OR mobile_number LIKE '%$lowerCaseQuery%'
      """);
      filteredPatientList.value = listPatient;
    } else {
      fetchPatientNames();
    }
  }


  Future<void> selectMenuItem(int index) async {
    selectedIndex.value = index;
  }
}

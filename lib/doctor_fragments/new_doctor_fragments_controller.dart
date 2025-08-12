import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DoctorListController extends GetxController {
  var doctorList = <Map<String, dynamic>>[].obs;
  var filteredDoctorList = <Map<String, dynamic>>[].obs;
  Database db = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchDoctorNames();
  }

  Future<void> fetchDoctorNames() async {
    try {
      // Fetch doctor information
      List<Map<String, dynamic>> list = await db.rawQuery(
          "SELECT id, first_name, last_name, degree, start_time, end_time, is_active FROM doctor LIMIT 50"
      );
      doctorList.value = list;
      filteredDoctorList.value = List.from(list);
    } catch (e) {
      debugPrint("DB Error: $e");
    }
  }

  /// Deletes a doctor from DB and updates lists


  // Search function (optional)
  Future<void> updateSearch(String query) async {
    final lowerCaseQuery = query.toLowerCase();

    final results = doctorList.where((item) {
      final fullName = '${item['first_name']} ${item['last_name']}'.toLowerCase();
      final degree = item['degree']?.toString().toLowerCase() ?? '';
      return fullName.contains(lowerCaseQuery) || degree.contains(lowerCaseQuery);
    }).toList();

    filteredDoctorList.value = results;
  }
}

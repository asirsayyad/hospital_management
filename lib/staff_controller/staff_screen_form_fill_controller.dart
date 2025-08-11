import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class StaffPatientFormController extends GetxController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController mobilenumberController;
  late TextEditingController dobController;
  late TextEditingController bloodGroupController;
  late TextEditingController statecontroller;
  late TextEditingController cityController;
  late TextEditingController principlesController;

  var selectedDate = Rx<DateTime?>(null);
  Database db = Get.find();

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    mobilenumberController =TextEditingController();
    dobController = TextEditingController();
    bloodGroupController = TextEditingController();
    statecontroller = TextEditingController();
    cityController = TextEditingController();
    principlesController = TextEditingController();
    super.onInit();
  }

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dobController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<void> savePatientForm() async {

    Future<void> insertPatient({required Database db}) async {
      try {
        String currentDate = DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now());
        // Full date-time format

        String query = '''
      INSERT INTO patient (
        name,
        last_name,
        mobile_number,
        dob,
        blood_group,
        state,
        city,
        pincode,
        registration_date
      ) VALUES (
        '${firstNameController.text.trim()}',
        '${lastNameController.text.trim()}',
         '${mobilenumberController.text.trim()}',
        '${dobController.text.trim()}',
        '${bloodGroupController.text.trim()}',
        '${statecontroller.text.trim()}',
        '${cityController.text.trim()}',
        '${principlesController.text.trim()}',
        '$currentDate'
      );
    ''';

        await db.rawInsert(query);
        debugPrint("Patient inserted successfully.");
      } catch (e) {
        debugPrint("Error inserting patient: $e");
      }
    }


    print("Save button pressed");

    if (firstNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please enter first name'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Add return to stop execution
    } else if (lastNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please enter last name'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Add return to stop execution
    } else if (dobController.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please select date of birth'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Add return to stop execution
    } else if (bloodGroupController.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please enter blood group'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Add return to stop execution
    } else if (mobilenumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please enter mobile number'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Add return to stop execution
    } else if (statecontroller.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please enter state'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Add return to stop execution
    } else if (cityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please enter city'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Add return to stop execution
    } else if (principlesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please enter pincode'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Add return to stop execution
    }

    // This block will ONLY execute if ALL validations pass
    await insertPatient(db: db);
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('Patient form saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    Get.back();
  }
}

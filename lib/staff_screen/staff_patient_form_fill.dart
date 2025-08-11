import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/staff_controller/staff_screen_form_fill_controller.dart';

// import 'StaffPatientFormController.dart';

class StaffPatientFormFill extends StatelessWidget {
  const StaffPatientFormFill({super.key});

  @override
  Widget build(BuildContext context) {
    final StaffPatientFormController controller = Get.put(StaffPatientFormController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter first name',
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: controller.lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter last name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.mobilenumberController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                hintText: 'Please Enter Mobile number',
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: controller.dobController,
              readOnly: true,
              onTap: () => controller.selectDate(context),
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'Select date of birth',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: controller.bloodGroupController,
              decoration: InputDecoration(
                labelText: 'Blood Group',
                hintText: 'Enter blood group',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.statecontroller,
              decoration: InputDecoration(
                labelText: 'State',
                hintText: 'Enter State',
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: controller.cityController,
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'Enter city',
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: controller.principlesController,
              decoration: InputDecoration(
                labelText: 'pincode',
                hintText: 'Enter pincode'
              ),


            ),
            ElevatedButton(onPressed: (){
              controller.savePatientForm();
              // Get.back();
            }, child: Text("Save"))
          ],
        ),
      ),
    );
  }
}

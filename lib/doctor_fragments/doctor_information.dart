import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'doctor_information_controller.dart';
// import 'doctor_controller.dart';

class DoctorForm extends StatelessWidget {
  const DoctorForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Information"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('First Name:'),
              SizedBox(height: 8),
              TextFormField(
                controller: controller.firstNameController,
                decoration: InputDecoration(
                  hintText: 'Enter first name',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              Text('Last Name:'),
              SizedBox(height: 8),
              TextFormField(
                controller: controller.lastNameController,
                decoration: InputDecoration(
                  hintText: 'Enter last name',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              Text('Degree:'),
              SizedBox(height: 8),
              TextFormField(
                controller: controller.degreeController,
                decoration: InputDecoration(
                  hintText: 'e.g., MBBS, MD, MS',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              Text('Start Time:'),
              SizedBox(height: 8),
              TextFormField(
                controller: controller.startTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select start time',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    controller.selectStartTime(pickedTime);
                  }
                },
              ),

              SizedBox(height: 20),

              Text('End Time:'),
              SizedBox(height: 8),
              TextFormField(
                controller: controller.endTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select end time',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    controller.selectEndTime(pickedTime);
                  }
                },
              ),

              SizedBox(height: 20),

              Text('Gender:'),
              SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedGender.value.isEmpty
                    ? null
                    : controller.selectedGender.value,
                hint: Text('Select gender'),
                items: controller.genders.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) controller.selectGender(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )),

              SizedBox(height: 20),

              Text('Status:'),
              SizedBox(height: 8),
              Obx(() => SwitchListTile(
                title: Text('Is Active'),
                value: controller.isActive.value,
                onChanged: (value) {
                  controller.toggleActiveStatus(value);
                },
              )),

              SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.saveDoctorInfo();
                  },
                  child: Text('Save Doctor Information'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

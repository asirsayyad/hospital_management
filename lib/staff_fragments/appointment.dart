import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/staff_fragments/appointment_form.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(), // Your main body content here

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AppointmentForm());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // bottom-right
    );
  }
}

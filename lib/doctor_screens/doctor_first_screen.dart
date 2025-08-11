import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/doctor_fragments/medicines.dart';
import 'package:hospital_management/staff_fragments/appointment.dart';
import 'package:hospital_management/staff_screen/staff_patient_form_fill.dart';
import '../doctor_fragments/patient_list_controller.dart';
import '../doctor_fragments/patients_showlist.dart';
import '../staff_controller/staff_first_screen_controller.dart';
import '../staff_fragments/patients_showlist.dart';

class DoctorFirstScreen extends StatelessWidget {
  const DoctorFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
  patient_list_controller controller = Get.put(patient_list_controller());

    return Scaffold(
      body: Row(
        children: [
          // Left menu
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    controller.fetchPatientNames();
                    controller.selectMenuItem(0); // Show Patient screen
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Patient', style: TextStyle(fontSize: 16)),
                  ),
                ),
                InkWell(
                  onTap: () => controller.selectMenuItem(1), // Show Appointment screen
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: const Text('medicine', style: TextStyle(fontSize: 16)),
                  ),
                ),
                InkWell(

                  onTap: () { controller.selectMenuItem(2);}, // Show Dashboard screen
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Dashboard', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),

          // Right side content
          Expanded(
            child: Column(
              children: [
                // Search bar (only show for patient and appointment lists)
                Obx(() {
                  if (controller.selectedIndex.value == 0 || controller.selectedIndex.value == 1) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        onChanged: controller.updateSearch,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),

                // Screen content
                Expanded(
                  child: Obx(() {
                    switch (controller.selectedIndex.value) {
                      case 0:
                        return Patients();
                      case 1:
                        return Medicines();
                      case 2:
                        return const Center(
                          child: Text(
                            "Dashboard Screen",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      default:
                        return const SizedBox();
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ));}
}

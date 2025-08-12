import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/doctor_fragments/new_doctor_fragments.dart';
import 'package:hospital_management/staff_fragments/appointment.dart';
import 'package:hospital_management/staff_screen/staff_patient_form_fill.dart';
import '../staff_controller/staff_first_screen_controller.dart';
import '../staff_fragments/patients_showlist.dart';

class StaffFirstScreen extends StatelessWidget {
  const StaffFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
     StaffFirstScreenController controller = Get.put(StaffFirstScreenController());

    return Scaffold(
      body: Row(
        children: [
          // Left menu
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            color: Colors.green[50],
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
                    child: const Text('Appointment', style: TextStyle(fontSize: 16)),
                  ),
                ),
                InkWell(
                  onTap: () => controller.selectMenuItem(2), // Show Dashboard screen
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Dashboard', style: TextStyle(fontSize: 16)),
                  ),
                ),
                InkWell(
                  onTap: () => controller.selectMenuItem(3), // Show Dashboard screen
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Doctors', style: TextStyle(fontSize: 16)),
                  ),
                )
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
                        return PatientsShowlist();
                      case 1:
                        return Appointment();
                      case 2:
                        return const Center(
                          child: Text(
                            "Dashboard Screen",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      case 3:
                        return NewDoctorFragments();
                      default:
                        return const SizedBox();
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: Obx(() {
        // Show FAB only on Patient screen
        if (controller.selectedIndex.value == 0) {
          return FloatingActionButton(
            onPressed: () {
              Get.to(() => StaffPatientFormFill());
            },
            child: const Icon(Icons.add),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

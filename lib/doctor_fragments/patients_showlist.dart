// patients_showlist.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/doctor_fragments/patient_historyscreen.dart';
import 'package:hospital_management/doctor_fragments/patient_list_controller.dart';
import 'package:sqflite/sqflite.dart';
import '../staff_controller/staff_first_screen_controller.dart';

class Patients extends StatelessWidget {
  const Patients({super.key});

  @override
  Widget build(BuildContext context) {
    // use Get.find() to get the same controller instance created in the parent
    patient_list_controller controller = Get.put(patient_list_controller());
    Database db = Get.find();

    return Obx(() {
      final list = controller.filteredPatientList;
      if (list.isEmpty) return const Center(child: Text('No patients found.'));

      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final patient = list[index];
          final id = patient['id'] is int ? patient['id'] as int : int.tryParse('${patient['id']}') ?? 0;

          return ListTile(
            onTap: () {
              final patientId = patient['id'] is int
                  ? patient['id'] as int
                  : int.tryParse('${patient['id']}') ?? 0;

              final patientName =
              '${patient['name'] ?? ''} ${patient['last_name'] ?? ''}'.trim();

              Get.to(() => PatientHistoryScreen(
                patientId: patientId,
                patientName: patientName,
              ));
            },
            title: Text('${patient['name'] ?? ''} ${patient['last_name'] ?? ''}'),
            subtitle: Text('Mob No. : ${patient['mobile_number']?.toString() ?? ''}'),
            leading: const Icon(Icons.person),
            trailing: IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: () {
                 // pass the patient id
              },
            ),
          );
        },
      );
    });
  }
}

// patients_showlist.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../staff_controller/staff_first_screen_controller.dart';

class PatientsShowlist extends StatelessWidget {
  const PatientsShowlist({super.key});

  @override
  Widget build(BuildContext context) {
    // use Get.find() to get the same controller instance created in the parent
     StaffFirstScreenController controller = Get.put(StaffFirstScreenController());
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
            onTap: (){},
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

// patients_showlist.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../staff_controller/Staff_first_screen_controller.dart';

import '../staff_controller/staff_first_screen_controller.dart';


class PatientsShowlist extends StatelessWidget {
  const PatientsShowlist({super.key});

  @override
  Widget build(BuildContext context) {
    // Create/Get controller instance here
    final controller = Get.put(StaffFirstScreenController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Patient'),
      ),
      body: Obx(() {
        final list = controller.filteredPatientList;

        if (list.isEmpty) {
          return const Center(child: Text('No patients found.'));
        }

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final patient = list[index];
            final patientName =
                '${patient['name'] ?? ''} ${patient['last_name'] ?? ''}';
            final id = patient['id'] is int
                ? patient['id'] as int
                : int.tryParse('${patient['id']}') ?? 0;

            return ListTile(
              onTap: () {
                // Return the selected patient name
                Get.back(result: patientName);
              },
              title: Text(patientName),
              subtitle: Text(
                  'Mob No. : ${patient['mobile_number']?.toString() ?? ''}'),
              leading: const Icon(Icons.person),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                tooltip: "Delete",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Patient'),
                        content: Text(
                            'Are you sure you want to delete the registration of:'
                                ' $patientName?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {

                              Navigator.pop(context);
                              controller.deletePatient(id); // ✅ call directly
                            },
                            child: const Text('Delete',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}

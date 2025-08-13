// patients_showlist.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../staff_controller/staff_first_screen_controller.dart';

class PatientsShowlist extends StatelessWidget {
  const PatientsShowlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Patient'),
      ),
      body: GetBuilder<StaffFirstScreenController>(
        init: StaffFirstScreenController(),
        builder: (controller) {
          return Obx(() {
            final list = controller.filteredPatientList;
            if (list.isEmpty) return const Center(child: Text('No patients found.'));

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final patient = list[index];
                final patientName = '${patient['name'] ?? ''} ${patient['last_name'] ?? ''}';

                return ListTile(
                  onTap: () {
                    // Return the selected patient name
                    Get.back(result: patientName);
                  },
                  title: Text(patientName),
                  subtitle: Text(
                    'Mob No. : ${patient['mobile_number']?.toString() ?? ''}',
                  ),
                  leading: const Icon(Icons.person),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
            );
          });
        },
      ),
    );
  }
}

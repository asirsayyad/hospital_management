import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/staff_screen/staff_patient_form_fill.dart';

import '../staff_controller/Staff_first_screen_controller.dart';

class StaffFirstScreen extends StatelessWidget {
  const StaffFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StaffFirstScreenController controller = Get.put(StaffFirstScreenController());

    return Scaffold(
      body: Row(
        children: [
          // Left side menu - 20% of screen width
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    controller.fetchPatientNames(); // fetch patient list from DB
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    // color: Colors.blue[100],
                    child: const Text(
                      'Patient',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.selectMenuItem(1),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Appointment',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.selectMenuItem(2),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right side content - 80% of screen width
          Expanded(
            child: Column(
              children: [
                // Search bar at top
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: controller.updateSearch,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),

                // ListView showing real patient data
                Expanded(
                  child: Obx(() {
                    final filteredList = controller.filteredPatientList;

                    if (filteredList.isEmpty) {
                      return const Center(child: Text('No patients found.'));
                    }

                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final patient = filteredList[index];
                        return ListTile(
                          title: Text(
                              '${patient['name'] ?? ''} ${patient['last_name'] ?? ''}'),
                          subtitle: Text("${patient["mobile_number"]}"),
                          leading: const Icon(Icons.person),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => StaffPatientFormFill());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

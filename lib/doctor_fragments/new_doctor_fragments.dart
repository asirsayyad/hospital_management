import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/doctor_fragments/doctor_information.dart';
import 'new_doctor_fragments_controller.dart';

class NewDoctorFragments extends StatelessWidget {
  const NewDoctorFragments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Doctor"),
      ),
      body: GetBuilder<DoctorListController>(
        init: DoctorListController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Obx(() {
                  final doctorList = controller.filteredDoctorList;
                  if (doctorList.isEmpty) {
                    return const Center(child: Text('No doctors found.'));
                  }

                  return ListView.builder(
                    itemCount: doctorList.length,
                    itemBuilder: (context, index) {
                      final doctor = doctorList[index];
                      final isActive = doctor['is_active'] == 1;
                      final doctorName = 'Dr. ${doctor['first_name'] ?? ''} ${doctor['last_name'] ?? ''}';

                      return ListTile(
                        onTap: () {
                          // Return the selected doctor name
                          Get.back(result: doctorName);
                        },
                        title: Text(
                          doctorName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Degree: ${doctor['degree'] ?? 'N/A'}'),
                            Text('Time: ${doctor['start_time'] ?? ''} - ${doctor['end_time'] ?? ''}'),
                          ],
                        ),
                        leading: Icon(Icons.person),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isActive ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => DoctorForm())?.then((_) {
            final controller = Get.find<DoctorListController>();
            controller.fetchDoctorNames();
          });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/doctor_fragments/doctor_information.dart';
// import 'package:hospital_management/staff_fragments/appointment_form.dart';
// import 'doctor_list_controller.dart';
import 'new_doctor_fragments_controller.dart'; // Import your controller

class NewDoctorFragments extends StatelessWidget {
  const NewDoctorFragments({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorListController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors"),
      ),
      body: Column(
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

                  return ListTile(
                    title: Text(
                      '${doctor['first_name'] ?? ''} ${doctor['last_name'] ?? ''}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Degree: ${doctor['degree'] ?? 'N/A'}'),
                        Text('Time: ${doctor['start_time'] ?? ''} - ${doctor['end_time'] ?? ''}'),
                      ],
                    ),
                    leading:Icon(Icons.person),
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
                        IconButton(
                          icon: Icon(Icons.delete, size: 20),
                          onPressed: () {

                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => DoctorForm())?.then((_) {
            // Refresh the list when returning from doctor form
            controller.fetchDoctorNames();
          });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

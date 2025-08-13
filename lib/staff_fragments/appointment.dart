import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/staff_fragments/appointment_form.dart';
import 'appointment_controller.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: GetBuilder<AppointmentListController>(
        init: AppointmentListController(), // Controller in onInit
        builder: (controller) {
          return Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: controller.updateSearch,
                  decoration: const InputDecoration(
                    hintText: 'Search appointments...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Appointments list
              Expanded(
                child: Obx(() {
                  final list = controller.filteredAppointmentList;
                  if (list.isEmpty) {
                    return const Center(child: Text('No appointments found.'));
                  }

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final appointment = list[index];
                      final id = appointment['id'] is int
                          ? appointment['id'] as int
                          : int.tryParse('${appointment['id']}') ?? 0;

                      final status = appointment['status']?.toString() ?? 'Unknown';

                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          onTap: () {
                            // Handle appointment tap
                          },
                          title: Text(
                            '${appointment['doctor_name'] ?? 'Unknown Doctor'}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Visit Type: ${appointment['visit_type'] ?? 'N/A'}'),
                              Text('Date: ${appointment['appointment_date'] ?? 'N/A'}'),
                              Text('Time: ${appointment['appointment_time'] ?? 'N/A'}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: controller.getStatusColor(status),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Add delete confirmation dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Appointment'),
                                        content: Text('Are you sure you want to delete this appointment?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller.deleteAppointment(id);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Delete', style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text('Delete', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
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
          Get.to(() => AppointmentForm())?.then((_) {
            // Refresh the list when returning from appointment form
            final controller = Get.find<AppointmentListController>();
            controller.fetchAppointments();
          });
        },
        backgroundColor: Colors.blue,
        child: Text('+'),
      ),
    );
  }
}

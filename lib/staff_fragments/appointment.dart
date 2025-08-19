import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/staff_fragments/appointment_form.dart';
import 'appointment_controller.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    AppointmentListController controller = Get.put(AppointmentListController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: controller.updateSearch,
                    decoration: const InputDecoration(
                      hintText: 'Search appointments...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Obx(() => InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 365)),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        controller.filterBySelectedDate(pickedDate);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        controller.selectedDateText.value.isEmpty
                            ? 'Select Date'
                            : controller.selectedDateText.value,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    controller.fetchAllAppointments();
                  },
                  child: Text("All"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                )
              ],
            ),

          ),
          Expanded(
            child: Obx(() {
              final list = controller.filteredAppointmentList;
              if (list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No appointments found.'),
                      if (controller.selectedDateText.value.isNotEmpty)
                        Text(
                          'for ${controller.selectedDateText.value}',
                          style: TextStyle(color: Colors.grey),
                        ),
                    ],
                  ),
                );
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
                            // Status text only
                            Text(
                              status,
                              style: TextStyle(
                                color: controller.getStatusColor(status),
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Delete Icon
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete Appointment'),
                                      content: const Text('Are you sure you want to delete this appointment?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.deleteAppointment(id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        )

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
          Get.to(() => AppointmentForm())?.then((_) {
            controller.fetchAppointments();
          });
        },
        backgroundColor: Colors.blue,
        child: Text('Add'),
      ),
    );
  }
}

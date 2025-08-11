import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/doctor_fragments/patient_report.dart';
import 'package:intl/intl.dart';
import 'package:hospital_management/doctor_fragments/patient_list_controller.dart';

class PatientHistoryScreen extends StatelessWidget {
  final int patientId;
  final String patientName;

  const PatientHistoryScreen({
    super.key,
    required this.patientId,
    required this.patientName,
  });

  @override
  Widget build(BuildContext context) {
    patient_list_controller controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text("History - $patientName")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.fetchPatientHistory(patientId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No visit history found."));
          }

          final visits = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: visits.map((visit) {
                // Format the date & time
                String rawDate = visit['visit_date'] ?? '';
                String rawTime = visit['visit_time'] ?? '';
                String formattedDate = '';
                String formattedTime = '';

                try {
                  // If your DB stores date in ISO format or yyyy-MM-dd, parse and format it
                  DateTime date = DateTime.parse(rawDate);
                  formattedDate = DateFormat('dd MMMM yyyy').format(date);
                } catch (_) {
                  formattedDate = rawDate; // fallback if parse fails
                }

                formattedTime = rawTime;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "$formattedDate  $formattedTime",
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    floatingActionButton: Obx(() {
    // Show FAB only on Patient screen
    if (controller.selectedIndex.value == 0) {
    return FloatingActionButton(
    onPressed: () {
    Get.to(() => PatientReport());
    },
    child: const Icon(Icons.add),
    );
    }
    return const SizedBox();
    }
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/staff_fragments/patients_showlist.dart';
import 'package:hospital_management/doctor_fragments/new_doctor_fragments.dart';
import 'appointment_form_controller.dart';

class AppointmentForm extends StatelessWidget {
  const AppointmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentFormController());

    return Scaffold(
      appBar: AppBar(title: Text("Appointment Schedule")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient Name:'),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                // Navigate to patient list and wait for result
                final result = await Get.to(() => PatientsShowlist());
                if (result != null && result is String) {
                  controller.selectPatient(result);
                }
              },
              child: IgnorePointer(
                child: Obx(() => TextFormField(
                  controller: controller.patientNameController,
                  decoration: InputDecoration(
                    hintText: controller.selectedPatientName.value.isEmpty
                        ? 'Select patient'
                        : controller.selectedPatientName.value,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                )),
              ),
            ),

            SizedBox(height: 20),

            Text('Doctor Name:'),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                // Navigate to doctor list and wait for result
                final result = await Get.to(() => NewDoctorFragments());
                if (result != null && result is String) {
                  controller.selectDoctor(result);
                }
              },
              child: IgnorePointer(
                child: Obx(() => TextFormField(
                  controller: controller.doctorNameController,
                  decoration: InputDecoration(
                    hintText: controller.selectedDoctorName.value.isEmpty
                        ? 'Select doctor'
                        : controller.selectedDoctorName.value,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                )),
              ),
            ),

            SizedBox(height: 20),

            Text('Visit Type:'),
            SizedBox(height: 8),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedVisitType.value.isEmpty ? null : controller.selectedVisitType.value,
              hint: Text('Select visit type'),
              items: controller.visitTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.selectVisitType(value);
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            )),

            SizedBox(height: 20),

            Text('Select Date:'),
            SizedBox(height: 8),
            Obx(() => ListTile(
              title: Text("${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.selectedDate.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null) controller.selectDate(pickedDate);
              },
            )),

            SizedBox(height: 20),

            Text('Select Time:'),
            SizedBox(height: 8),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedTimeSlot.value.isEmpty ? null : controller.selectedTimeSlot.value,
              hint: Text('Choose time slot'),
              items: controller.timeSlots.map((time) {
                return DropdownMenuItem(value: time, child: Text(time));
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.selectTimeSlot(value);
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            )),

            SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.scheduleAppointment,
                child: Text('Schedule Appointment'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

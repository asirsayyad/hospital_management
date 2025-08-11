import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'appointment_controller.dart';

class AppointmentForm extends StatelessWidget {
  const AppointmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Schedule"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Doctor:'),
            SizedBox(height: 8),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedDoctor.value.isEmpty
                  ? null
                  : controller.selectedDoctor.value,
              hint: Text('Choose a doctor'),
              items: controller.doctors.map((doctor) {
                return DropdownMenuItem(
                  value: doctor,
                  child: Text(doctor),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.selectDoctor(value);
              },
            )),

            SizedBox(height: 20),

            Text('Visit Type:'),
            SizedBox(height: 8),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedVisitType.value.isEmpty
                  ? null
                  : controller.selectedVisitType.value,
              hint: Text('Select visit type'),
              items: controller.visitTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.selectVisitType(value);
              },
            )),

            SizedBox(height: 20),

            Text('Select Date:'),
            SizedBox(height: 8),
            Obx(() => ListTile(
              title: Text(
                  "${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}"
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.selectedDate.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null) {
                  controller.selectDate(pickedDate);
                }
              },
            )),

            SizedBox(height: 20),

            Text('Select Time:'),
            SizedBox(height: 8),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedTimeSlot.value.isEmpty
                  ? null
                  : controller.selectedTimeSlot.value,
              hint: Text('Choose time slot'),
              items: controller.timeSlots.map((time) {
                return DropdownMenuItem(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.selectTimeSlot(value);
              },
            )),

            SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.scheduleAppointment();
                },
                child: Text('Schedule Appointment'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

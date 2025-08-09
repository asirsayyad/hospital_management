import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../doctor_screens_controller/doctor_first_screen_controller.dart';

class doctor_first_screen extends StatelessWidget {
  const doctor_first_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(doctor_first_screen_controller());

    return Scaffold(
      body: Row(
        children: [
          // Left Panel - 20%
        Expanded(
        flex: 2,
        child: Container(
          color: Colors.blue, // Background color for entire 20% panel
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child:  Center(
                  child: ListTile( onTap: (){},
                    title: Text(
                      'Patients',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),


          // Right Panel - 80%
          Expanded(
            flex: 8,
            child: Column(
              children: const [
                TextField(), // Search bar at top
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/controller_loading.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerLoading controllerLoading = Get.put(ControllerLoading());

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/hospital1.png',
              fit: BoxFit.cover,
            ),
          ),
          AppBar(
            backgroundColor: Colors.green.withOpacity(0.1),
            foregroundColor: Colors.black,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
        ],
      ),
    );
  }
}

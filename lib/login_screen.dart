// import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/staff_screen/staff_first_screen.dart';

import 'doctor_screens/doctors_login_screen.dart';

class ControllerLogin extends GetxController {
  final textEditingControllerPhoneNumber = TextEditingController();
  final textEditingControllerPassword = TextEditingController();
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ControllerLogin());

  void controllerLogin() {
    final phone = controller.textEditingControllerPhoneNumber.text.trim();
    final password = controller.textEditingControllerPassword.text;

    if (phone == "+918625012750" && password == "Admin@123") {
      Get.snackbar(
        "Login Successful",
        "Welcome back!",
        snackPosition: SnackPosition.BOTTOM,

        backgroundColor: Colors.green,
        colorText: Colors.white,


      );
      Get.to(StaffFirstScreen());
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid phone or password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Row(
          children: [
            Image.asset('assets/images/hospital.png', height: 50),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RH POS Hospital',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Staff Portal Login',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Get.to(() => const DoctorLoginScreen());
              },
              icon: Icon(Icons.medical_services_outlined, size: 16),
              label: Text('Doctors Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.local_hospital, color: Colors.blue[900]),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 800;
          return Row(
            children: [
              if (isWide)
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/hospital1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(color: Colors.black.withOpacity(0.6)),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Welcome to RH POS Hospital',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Cloud Based Hospital Management System',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 1),
                        height: double.infinity,
                        viewportFraction: 1.0,
                      ),
                      items:
                          [
                            'assets/images/hospitalre.png',
                            'assets/images/doctors.png',
                          ].map((imgPath) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    Container(color: Colors.white.withOpacity(0.1)),
                    Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RH POS Hospital',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                ' Staff Login',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Enter your phone number and password to login',
                              ),
                              SizedBox(height: 20),

                              // Phone Number
                              SizedBox(
                                height: 45,
                                width: 250,
                                child: TextFormField(
                                  controller: controller
                                      .textEditingControllerPhoneNumber,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    hintText: '+91XXXXXXXXXX',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Phone number is required';
                                    }
                                    if (!RegExp(
                                      r'^\+91\d{10}$',
                                    ).hasMatch(value.trim())) {
                                      return 'Enter valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20),

                              // Password
                              SizedBox(
                                height: 45,
                                width: 250,
                                child: TextFormField(
                                  controller:
                                      controller.textEditingControllerPassword,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: '*********',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    suffixIcon: Icon(Icons.lock),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text('Forgot Password?'),
                                ),
                              ),
                              SizedBox(height: 20),

                              // Sign In Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controllerLogin();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  child: Text(

                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Don't have an account? "),
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: Text('Sign Up'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/doctor_screens/doctor_first_screen.dart';
import 'package:hospital_management/doctor_screens/doctors_login_screen.dart';
// import 'package:hospital_management/first_screen.dart';
import 'package:hospital_management/loading_screen.dart';
import 'package:hospital_management/login_screen.dart';
import 'package:hospital_management/service_db.dart';
import 'package:hospital_management/staff_screen/staff_first_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await initSingleton(); //this is useed for globally declear for dio and database
  runApp(const MyApp());
}

Future<void> initSingleton() async {
  await Get.putAsync(
    () => ServiceDb().createDbInstance(),
  ); // Database db = Get.find();
  // await Get.putAsync(()=> ServiceDio().createDioInstance()); // Database db = Get.find();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StaffFirstScreen(),
    );
  }
}

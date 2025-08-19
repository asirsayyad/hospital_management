import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class ServiceDb {
  Future<Database> createDbInstance() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'hospital1.db'); //
    debugPrint(path);

    Database db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
           CREATE TABLE patient (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  hospital_id INTEGER,
  patient_id TEXT,
  name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  mobile_number TEXT,
  dob TEXT,
  blood_group TEXT,
  state TEXT,
  city TEXT,
  pincode TEXT,
  registration_date TEXT
);
          ''');
          await db.execute('''
           CREATE TABLE appointments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  patient_id INTEGER,
  doctor_name TEXT NOT NULL,
  visit_type TEXT NOT NULL,
  appointment_date TEXT NOT NULL,
  appointment_time TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'Scheduled',
  created_date TEXT,
  FOREIGN KEY (patient_id) REFERENCES patient (id)
);
          ''');
          await db.execute('''
           CREATE TABLE doctor (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  degree TEXT NOT NULL,
  start_time TEXT NOT NULL,
  end_time TEXT NOT NULL,
  gender TEXT NOT NULL,
  is_active INTEGER DEFAULT 1,
  created_date TEXT
);
          ''');
        },
      ),
    );
    return db;
  }
}

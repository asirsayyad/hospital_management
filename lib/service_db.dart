import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class ServiceDb {
  Future<Database> createDbInstance() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'hospital.db'); //
    debugPrint(path);

    Database db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
           CREATE TABLE patient (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
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

        },
      ),
    );
    return db;
  }
}

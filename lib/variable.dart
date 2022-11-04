import 'package:studee/main.dart';
import 'package:studee/variable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/page_note.dart';
import 'package:studee/page_task.dart';
import 'package:studee/page_timetable.dart';
import 'package:firebase_auth/firebase_auth.dart';

var user = FirebaseAuth.instance.currentUser;
var uid = user!.uid;
var appColorTheme = Color.fromARGB(255, 0, 180, 81);
var defaultAppColorTheme = Color.fromARGB(255, 0, 180, 81);
var backgroundColorTheme = Color.fromARGB(255, 229, 255, 230);
final store = FirebaseFirestore.instance;
String ID = "";
String Day = "";
int? cur_page;
String day = '';
String globalDay = "monday";
//userFullName get from store.collection('studee').doc(uid).get()
var userFullName = FutureBuilder<DocumentSnapshot>(
  future: store.collection('studee').doc(uid).get(),
  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.hasError) {
      return Text("โหลดไม่สำเร็จ");
    }
    if (snapshot.connectionState == ConnectionState.done) {
      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
      return Text("${data['name']}");
    }
    return Text("กำลังโหลด..");
  },
);

var dateName = [
  'monday',
  'tuesday',
  'wednesday',
  'thursday',
  'friday',
  'saturday',
  'sunday'
];
const List<Tab> tabs = <Tab>[
  Tab(
    text: 'Mon',
  ),
  Tab(text: 'Tue'),
  Tab(text: 'Wed'),
  Tab(
    text: 'Thu',
  ),
  Tab(text: 'Fri'),
  Tab(text: 'Sat'),
  Tab(text: 'Sun'),
];

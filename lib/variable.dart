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
var uid = 'Is4z0tu3tUYSKuOt9NoCwXDTTZl1'; //user!.uid;
var appColorTheme = Color.fromARGB(255, 0, 180, 81);
var defaultAppColorTheme = Color.fromARGB(255, 0, 180, 81);
var backgroundColorTheme = Color.fromARGB(255, 229, 255, 230);
final store = FirebaseFirestore.instance;
String ID = "";
String Day = "";
String globalDay = "";
int? cur_page;
String day = '';
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

getNamefromFirestore() async {
  var user = FirebaseAuth.instance.currentUser;
  var uid = user!.uid;
  var doc = await store.collection('users').doc(uid).get();
  var name = doc['name'];
  return name;
}

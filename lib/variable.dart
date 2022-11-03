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
var uid = "QhsZSqCBJjbfq4Tsoh5g9MDWNGn1"; //user!.uid;
var appColorTheme = Color.fromARGB(255, 0, 180, 81);
var defaultAppColorTheme  = Color.fromARGB(255, 0, 180, 81);
final store = FirebaseFirestore.instance;
String ID = "";
String Day = "";
int? cur_page;
String day = '';
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

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
var uid = "HU7CkoiqOfWK14cnz0gVpYCy7tP2"; //user!.uid;
final store = FirebaseFirestore.instance;
String ID = "";
int? cur_page;
String day = 'monday';
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

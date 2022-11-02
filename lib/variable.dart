import 'package:studee/main.dart';
import 'package:studee/variable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/pase_note.dart';
import 'package:studee/pase_task.dart';
import 'package:studee/pase_timetable.dart';

int? cur_page;
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

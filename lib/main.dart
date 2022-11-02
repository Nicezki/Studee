import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/view_subject.dart';
import 'package:studee/register.dart';
import 'package:studee/login.dart';
import 'package:studee/tabuser.dart';
import 'package:studee/pase_note.dart';
import 'package:studee/pase_task.dart';
import 'package:studee/pase_timetable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  final appTitle = 'Example Form';

  const MyHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(title: appTitle),
        '/LoginPage': (context) => LoginPage(),
        '/RegisterPage': (context) => RegisterPage(),
        '/add_SecondPage': (context) => add_SecondPage(),
        '/add_SecondPage2': (context) => add_SecondPage2(),
        '/add_SecondPage3': (context) => add_SecondPage3(),
        '/view_subject': (context) => SubjectDetail('00000888'),
      },
      //home: MyApp(title: appTitle),
    );
  }
}

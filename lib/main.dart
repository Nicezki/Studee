import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';
import 'package:studee/view_subject.dart';
import 'package:studee/register.dart';
import 'package:studee/login.dart';
import 'package:studee/tabuser.dart';
import 'package:studee/page_note.dart';
import 'package:studee/page_task.dart';
import 'package:studee/page_timetable.dart';
import 'package:studee/view_notes.dart';
import 'package:studee/view_todolist.dart';
import 'package:studee/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyHome());
}



class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Studee';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
       appBarTheme: AppBarTheme(
          color: appColorTheme,
        ),
       fontFamily: 'IBMPlexSansThai', 
        ),

      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(title: appTitle),
        '/LoginPage': (context) => LoginPage(),
        '/RegisterPage': (context) => RegisterPage(),
        '/add_SecondPage': (context) => add_SecondPage(),
        '/add_SecondPage2': (context) => add_SecondPage2(),
        '/add_SecondPage3': (context) => add_SecondPage3(),
        '/view_subject': (context) => SubjectDetail(ID),
        '/view_note': (context) => NoteDetail(ID),
        '/test': (context) => MyApp2(),
      },
      //home: MyApp(title: appTitle),
    );
  }
}
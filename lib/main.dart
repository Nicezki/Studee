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
import 'package:studee/view_todolist.dart';
import 'package:studee/addnote.dart';
import 'package:studee/addtable.dart';
import 'package:studee/addtodolist.dart';

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
        '/add_SecondPage': (context) => AddNote(),
        '/add_SecondPage2': (context) => AddTable(),
        '/add_SecondPage3': (context) => AddTable2(),
        '/view_subject': (context) => SubjectDetail(ID),
        '/view_note': (context) => NoteDetail(ID),
        '/test': (context) => MyApp2(),
        '/view_todolist': (context) => TaskDetail(ID),
      },
      //home: MyApp(title: appTitle),
    );
  }
}

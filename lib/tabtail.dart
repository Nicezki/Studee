import 'package:studee/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/page_note.dart';
import 'package:studee/page_task.dart';
import 'package:studee/page_timetable.dart';
import 'package:studee/variable.dart';
import 'package:studee/addnote.dart';
import 'package:studee/addtable.dart';
import 'package:studee/addtodolist.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyStatelessWidget1(),
    MyStatelessWidget2(),
    MyStatelessWidget3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      cur_page = index;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 0, 180, 81),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Time-Table',
            // activeIcon: TabBarDemo(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Task',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[200],
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

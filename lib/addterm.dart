import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Addterm extends StatefulWidget {
  const Addterm({Key? key}) : super(key: key);
  @override
  State<Addterm> createState() => _AddNoteState();
}

class _AddNoteState extends State<Addterm> {
  final _addnote = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _class = TextEditingController();
  final _message = TextEditingController();
  final _tage = TextEditingController();
  final store = FirebaseFirestore.instance;
  var uploadurl;

  File? _avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.book),
          title: Text('เพิ่มเทอม'),
        ),
        body: Container(
          key: _addnote,
          child: SafeArea(
              child: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    nameBox(),
                    SizedBox(
                      height: 10,
                    ),
                    registerButton(),
                  ],
                )),
          )),
          color: Color.fromARGB(255, 255, 255, 255),
        ));
  }
//}****

  ElevatedButton registerButton() {
    return ElevatedButton(
        child: Container(
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("บันทึก", style: TextStyle(fontSize: 20)),
            ],
          )),
        ),
        onPressed: () async {
          //if (_addnote.currentState!.validate());// {
          print('save button press');
          Map<String, dynamic> data = {
            'color': '#29a329',
            'title': _name.text,
            'details': _message.text,
            'type': _tage.text,
            'image': uploadurl,
          };
          try {
            Future addUserCollection(var user) async {
              await FirebaseFirestore.instance
                  .collection('studee')
                  .doc(uid)
                  .collection(_name.text)
                  .doc();
              await FirebaseFirestore.instance
                  .collection("studee")
                  .doc(uid)
                  .collection(_name.text)
                  .doc('info')
                  .set({
                'name': 'ตารางเรียนเริ่มต้น',
              });
              await FirebaseFirestore.instance
                  .collection("studee")
                  .doc(uid)
                  .collection(_name.text)
                  .doc('note')
                  .collection('1')
                  .doc()
                  .set({
                'color': "#FF0000",
                'details': "เขียน note ที่นี่",
                'title': "note สุดยอดเยี่ยมของคุณ",
                "type": "Lecture",
              });
              var days = [
                'sunday',
                'monday',
                'tuesday',
                'wednesday',
                'thursday',
                'friday',
                'saturday'
              ];
              days.forEach((String days) => FirebaseFirestore.instance
                      .collection("studee")
                      .doc(user.user!.uid)
                      .collection('timetable1')
                      .doc(_name.text)
                      .collection(days)
                      .doc()
                      .set({
                    "subj_name": "Mobile Device Programming",
                    "subj_code": "00123456",
                    "teacher_name": "นชิรัตน์ ราชบุรี",
                    "start_time": "09:00",
                    "end_time": "12:00",
                    "place": "32100",
                    "image":
                        "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
                    "details": "วิชาที่ยอดเยี่ยม อาจารย์สอนดีมาก",
                    "color": "#FF0000"
                  }));
              await FirebaseFirestore.instance
                  .collection("studee")
                  .doc(user.user!.uid)
                  .collection('timetable1')
                  .doc('todolist')
                  .collection('1')
                  .doc()
                  .set({
                "title": "ทำงาน App ส่งอาจารย์",
                "subj_code": "00123456",
                "details": "ทำงานกลุ่มส่งอาจารย์",
                "status": "in-progress",
                "image":
                    "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
                "color": "#FF0000",
                "start": "2022-09-25 10:00:00",
                "end": "2022-11-04 13:39:59"
              });
            }

            Navigator.pop(context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error $e'),
              ),
            );
          }
          ;
        });
  }

  TextFormField nameBox() {
    return TextFormField(
      controller: _name,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'ชื่อเทอม :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'โปรดใส่ชื่อเทอม';
        }
        return null;
      },
    );
  }
} //final

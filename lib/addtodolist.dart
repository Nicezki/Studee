import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';

class AddTable2 extends StatefulWidget {
  const AddTable2({Key? key}) : super(key: key);
  @override
  State<AddTable2> createState() => _AddTableState();
}

class _AddTableState extends State<AddTable2> {
  final _addtable = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _class = TextEditingController();
  final _startdate = TextEditingController();
  final _enddate = TextEditingController();
  final _details = TextEditingController();
  final store = FirebaseFirestore.instance;

  File? _avatar;
  onChooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.book),
          title: Text('เพิ่มสิ่งที่ต้องทำ'),
        ),
        body: Container(
          key: _addtable,
          child: SafeArea(
              child: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: ListView(
                  children: <Widget>[
                    _avatar == null
                        ? ElevatedButton(
                            onPressed: () {},
                            child: const Text('ใส่รูปภาพ'),
                          )
                        : Image.file(_avatar!),
                    SizedBox(
                      height: 10,
                    ),
                    nameclassBox(),
                    codeclassBox(),
                    startdateBox(),
                    enddateBox(),
                    detailsBox(),
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
            'title': _name.text,
            'subj_cod': _class.text,
            'start': _startdate.text,
            'end': _enddate.text,
            'detaile': _details.text,
          };
          try {
            DocumentReference ref = await store
                .collection('studee')
                .doc(uid)
                .collection('timetable1')
                .doc('timetable')
                .collection('monday')
                .add(data);
//FirebaseFirestore.instance.collection("studee").doc(user.user!.uid).collection('timetable1').doc('note').collection('1').doc()

            print('save id = ${ref.id}');

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

  TextFormField nameclassBox() {
    return TextFormField(
      controller: _name,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'หัวข้อ :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }

  TextFormField codeclassBox() {
    return TextFormField(
      controller: _class,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'วิชา :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }

  TextFormField startdateBox() {
    return TextFormField(
      controller: _startdate,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'วันที่สั่ง :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }

  TextFormField enddateBox() {
    return TextFormField(
      controller: _enddate,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'วันที่ส่ง :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }

  TextFormField detailsBox() {
    return TextFormField(
      controller: _details,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'รายละเอียด :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }
} //final

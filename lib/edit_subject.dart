import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:studee/variable.dart';

class EditSubject extends StatefulWidget {
  Map<String, dynamic> subjectItem;
  String dbid;
  EditSubject(this.dbid, this.subjectItem, {Key? key}) : super(key: key);

  Color pickerColor = Color(0xff443a49);

  @override
  State<EditSubject> createState() => _EditSubjectState();
}

var user = FirebaseAuth.instance.currentUser;
var user_id = user!.uid;


class _EditSubjectState extends State<EditSubject> {
  late TextEditingController _controllerCode;
  late TextEditingController _controllerName;
  late TextEditingController _controllerTeacher;
  late TextEditingController _controllerPlace;
  late TextEditingController _controllerDetails;
  late TextEditingController _controllerStart;
  late TextEditingController _controllerEnd;
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controllerCode =
        TextEditingController(text: widget.subjectItem['subj_code']);
    _controllerName =
        TextEditingController(text: widget.subjectItem['subj_name']);
    _controllerTeacher =
        TextEditingController(text: widget.subjectItem['teacher_name']);
    _controllerPlace = TextEditingController(text: widget.subjectItem['place']);
    _controllerDetails =
        TextEditingController(text: widget.subjectItem['details']);
    _controllerStart =
        TextEditingController(text: widget.subjectItem['start_time']);
    _controllerEnd =
        TextEditingController(text: widget.subjectItem['end_time']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขวิชา ' + _controllerName.text),
      ),
      body: Form(
        key: key,
        child: ListView(
          children: [
            buildCodeField(),
            buildNameField(),
            buildTeacherField(),
            buildPlaceField(),
            buildDetailsField(),
            buildStartField(),
            buildEndField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  TextFormField buildCodeField() {
    return TextFormField(
      controller: _controllerCode,
      decoration: InputDecoration(
        labelText: 'รายวิชา',
        icon: Icon(Icons.code),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกรายวิชา';
        } else {
          return null;
        }
      },
    );
  }
  

  TextFormField buildNameField() {
    return TextFormField(
      controller: _controllerName,
      decoration: InputDecoration(
        labelText: 'ชื่อวิชา',
        icon: Icon(Icons.book),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกชื่อวิชา';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField buildTeacherField() {
    return TextFormField(
      controller: _controllerTeacher,
      decoration: InputDecoration(
        labelText: 'อาจารย์ผู้สอน',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกชื่ออาจารย์ผู้สอน';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField buildPlaceField() {
    return TextFormField(
      controller: _controllerPlace,
      decoration: InputDecoration(
        labelText: 'สถานที่/ห้องเรียน',
        icon: Icon(Icons.place),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกสถานที่ เช่น ห้องเรียน หรือที่อยู่';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField buildDetailsField() {
    return TextFormField(
      controller: _controllerDetails,
      decoration: InputDecoration(
        labelText: 'รายละเอียด',
        icon: Icon(Icons.details),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกรายละเอียด';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField buildStartField() {
    return TextFormField(
      controller: _controllerStart,
      decoration: InputDecoration(
        labelText: 'เวลาเริ่ม',
        icon: Icon(Icons.start),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกเวลาเริ่ม';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField buildEndField() {
    return TextFormField(
      controller: _controllerEnd,
      decoration: InputDecoration(
        labelText: 'เวลาจบ',
        icon: Icon(Icons.star),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกเวลาจบ';
        } else {
          return null;
        }
      },
    );
  }

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          elevation: MaterialStateProperty.all(15),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
      onPressed: () {
        if (key.currentState!.validate()) {
          FirebaseFirestore.instance
              .collection('studee')
              .doc(user_id)
              .collection('timetable1')
              .doc('timetable')
              .collection(Day)
              .doc(widget.dbid)
              .update({
            'subj_code': _controllerCode.text,
            'subj_name': _controllerName.text,
            'teacher_name': _controllerTeacher.text,
            'place': _controllerPlace.text,
            'details': _controllerDetails.text,
            'start_time': _controllerStart.text,
            'end_time': _controllerEnd.text,
          }).then((value) => Navigator.pop(context));
        }
      },
      child: Text('บันทึก'),
    );
  }

  @override
  void dispose() {
    _controllerCode.dispose();
    _controllerName.dispose();
    _controllerTeacher.dispose();
    _controllerPlace.dispose();
    _controllerDetails.dispose();
    _controllerStart.dispose();
    _controllerEnd.dispose();
    super.dispose();
  }
}

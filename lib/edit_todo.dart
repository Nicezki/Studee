import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditTodo extends StatefulWidget {
  Map<String, dynamic> todoItem;
  EditTodo(this.dbid, this.todoItem, {Key? key}) : super(key: key);
  String dbid;

  Color pickerColor = Color(0xff443a49);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

var user = FirebaseAuth.instance.currentUser;
var user_id = user!.uid;

class _EditTodoState extends State<EditTodo> {
  late TextEditingController _controllerCode;
  late TextEditingController _controllerTitle;
  late TextEditingController _controllerStatus;
  late TextEditingController _controllerDetails;
  late TextEditingController _controllerStart;
  late TextEditingController _controllerEnd;
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controllerCode = TextEditingController(text: widget.todoItem['subj_code']);
    _controllerTitle = TextEditingController(text: widget.todoItem['title']);
    _controllerStatus = TextEditingController(text: widget.todoItem['status']);
    _controllerDetails =
        TextEditingController(text: widget.todoItem['details']);
    _controllerStart = TextEditingController(text: widget.todoItem['start']);
    _controllerEnd = TextEditingController(text: widget.todoItem['end']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขสิ่งที่ต้องทำ ' + _controllerTitle.text),
      ),
      body: Form(
        key: key,
        child: ListView(
          children: [
            buildTitleField(),
            buildCodeField(),
            buildStatusField(),
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

  TextFormField buildTitleField() {
    return TextFormField(
      controller: _controllerTitle,
      decoration: InputDecoration(
        labelText: 'ชื่อเรื่อง',
        icon: Icon(Icons.book),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกชื่อเรื่อง';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField buildStatusField() {
    return TextFormField(
      controller: _controllerStatus,
      decoration: InputDecoration(
        labelText: 'สถานะ',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกสถานะ';
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
              .doc('todolist')
              .collection('1')
              .doc(widget.dbid)
              .update({
            'title': _controllerTitle.text,
            'subj_code': _controllerCode.text,
            'status': _controllerStatus.text,
            'details': _controllerDetails.text,
            'start': _controllerStart.text,
            'end': _controllerEnd.text,
          }).then((value) => Navigator.pop(context));
        }
      },
      child: Text('บันทึก'),
    );
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerCode.dispose();
    _controllerStatus.dispose();
    _controllerDetails.dispose();
    _controllerStart.dispose();
    _controllerEnd.dispose();
    super.dispose();
  }
}

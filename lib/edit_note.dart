import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  Map<String, dynamic> noteItem;
  EditNote(this.dbid, this.noteItem, {Key? key}) : super(key: key);
  String dbid;

  @override
  State<EditNote> createState() => _EditNoteState();
}

var user = FirebaseAuth.instance.currentUser;
var user_id = user!.uid;

class _EditNoteState extends State<EditNote> {
  late TextEditingController _controllerDetails;
  late TextEditingController _controllerTitle;
  late TextEditingController _controllerType;
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controllerDetails =
        TextEditingController(text: widget.noteItem['details']);
    _controllerTitle = TextEditingController(text: widget.noteItem['title']);
    _controllerType = TextEditingController(text: widget.noteItem['type']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขบันทึก ' + _controllerTitle.text),
      ),
      body: Form(
        key: key,
        child: ListView(
          children: [
            buildTitleField(),
            buildTypeField(),
            buildDetailsField(),
            buildSaveButton(),
          ],
        ),
      ),
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

  TextFormField buildTypeField() {
    return TextFormField(
      controller: _controllerType,
      decoration: InputDecoration(
        labelText: 'ประเภท',
        icon: Icon(Icons.details),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'โปรดกรอกประเภท';
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
              .doc('note')
              .collection('1')
              .doc(widget.dbid)
              .update({
            'title': _controllerTitle.text,
            'type': _controllerType.text,
            'details': _controllerDetails.text,
          }).then((value) => Navigator.pop(context));
        }
      },
      child: Text('บันทึก'),
    );
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerType.dispose();
    _controllerDetails.dispose();
    super.dispose();
  }
}

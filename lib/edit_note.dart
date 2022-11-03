import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  Map<String,dynamic> noteItem;
  EditNote (this.noteItem,{Key? key}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

var user = FirebaseAuth.instance.currentUser;
var uid = user!.uid;

class _EditNoteState extends State<EditNote>{
  late TextEditingController _controllerDetails;
  late TextEditingController _controllerTitle;
  late TextEditingController _controllerType;
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controllerDetails = TextEditingController(text: widget.noteItem['details']);
    _controllerTitle = TextEditingController(text: widget.noteItem['title']);
    _controllerType = TextEditingController(text: widget.noteItem['type']);
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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
        labelText: 'Title',
        icon: Icon(Icons.book),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill title in blank';
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
        labelText: 'Type',
        icon: Icon(Icons.details),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill type in blank';
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
        labelText: 'Details',
        icon: Icon(Icons.details),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill details in blank';
        } else {
          return null;
        }
      },
    );
  }

  

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (key.currentState!.validate()) {
          FirebaseFirestore.instance
              .collection('studee')
              .doc(uid)
              .collection('timetable1')
              .doc(widget.noteItem['id'])
              .update({
            'title': _controllerTitle.text,
            'Type': _controllerType.text,
            'details': _controllerDetails.text,
          }).then((value) => Navigator.pop(context));
        }
      },
      child: Text('Save'),
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

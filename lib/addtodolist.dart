import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  var uploadurl;
  File? _avatar;
  onChooseImage(mode) async {
    final picker = ImagePicker();
    final pickedFile;
    if (mode == 0) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }
    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
        // uploadurl = addToFirebaseStorage(pickedFile.path);
        uploadurl = addToFirebaseStorage(pickedFile.path);
        //add to firebase storage
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
          title: Text('Add to do list'),
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
                        ? Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  onChooseImage(0);
                                },
                                child: Text('เลือกรูปภาพ'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  onChooseImage(1);
                                },
                                child: Text('ถ่ายรูป'),
                              ),
                            ],
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
              Text("Save", style: TextStyle(fontSize: 20)),
            ],
          )),
        ),
        onPressed: () async {
          //if (_addnote.currentState!.validate());// {
          print('save button press');
          Map<String, dynamic> data = {
            'title': _name.text,
            'subj_code': _class.text,
            'start': _startdate.text,
            'end': _enddate.text,
            'details': _details.text,
            'image': await uploadurl,
          };
          try {
            DocumentReference ref = await store
                .collection('studee')
                .doc(uid)
                .collection('timetable1')
                .doc('todolist')
                .collection('1')
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
        labelText: 'title :',
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
        labelText: 'subj_code :',
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
        labelText: 'start :',
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
        labelText: 'end :',
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
        labelText: 'details :',
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

addToFirebaseStorage(imagePath) async {
  File imageFile = File(imagePath);
  String fileName = imagePath.split('/').last;
  Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('studee/$fileName');
  UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
  TaskSnapshot taskSnapshot = await uploadTask;
  var url = await taskSnapshot.ref.getDownloadURL();
  print(url);
  return url;
}

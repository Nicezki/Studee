import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _addnote = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _class = TextEditingController();
  final _message = TextEditingController();
  final _tage = TextEditingController();
  final store = FirebaseFirestore.instance;
  var uploadurl;

  File? _avatar;
  onChooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
        // uploadurl = addToFirebaseStorage(pickedFile.path);
        uploadurl = FutureBuilder(
          future: addToFirebaseStorage(pickedFile.path),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else {
              return Text('https://timeoutcomputers.com.au/wp-content/uploads/2016/12/noimage.jpg');
            }
          },
        );
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
          title: Text('เพิ่มบันทึก'),
        ),
        body: Container(
          key: _addnote,
          child: SafeArea(
              child: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: ListView(
                  children: <Widget>[
                    _avatar == null
                        ? ElevatedButton(
                            onPressed: () {
                              onChooseImage();
                            },
                            child: const Text('ใส่รูปภาพ'),
                          )
                        : Image.file(_avatar!),
                    SizedBox(
                      height: 10,
                    ),
                    nameBox(),
                    //classBox(),
                    messageBox(),
                    tageBox(),
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
            DocumentReference ref = await store
                .collection('studee')
                .doc(uid)
                .collection('timetable1')
                .doc('note')
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

  TextFormField nameBox() {
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

  /* TextFormField classBox() {
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
  }*/

  TextFormField messageBox() {
    return TextFormField(
      controller: _message,
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

  TextFormField tageBox() {
    return TextFormField(
      controller: _tage,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'type :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }


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



} //final

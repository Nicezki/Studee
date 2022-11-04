import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  var currentColor = Color.fromARGB(255, 61, 169, 64);

  File? _avatar;

  onChooseImage(mode) async {
    final picker = ImagePicker();
    final pickedFile;
    if(mode == 0){
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }else{
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
          backgroundColor: currentColor,
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
                        ? Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor: currentColor,
                            ),
                              onPressed: () {
                                onChooseImage(0);
                              },
                              child: Text('เลือกรูปภาพ'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor: currentColor,
                            ),
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
                    colorPickButton(),
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

  ElevatedButton colorPickButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: currentColor,
      ),
      child: Text('เลือกสี'),
      onPressed: (){
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: const Text('เลือกสี'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('เลือก'),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }

  ElevatedButton registerButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: currentColor,
        ),
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
            'color': currentColor.value,
            'title': _name.text,
            'details': _message.text,
            'type': _tage.text,
            'image': await uploadurl,
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

  //Color picker button 
  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changeColor(Color color) => setState(() => currentColor = color);


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
  
}
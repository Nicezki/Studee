import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';
import 'package:firebase_storage/firebase_storage.dart';

var uploadurl;

class AddTable extends StatefulWidget {
  const AddTable({Key? key}) : super(key: key);
  @override
  State<AddTable> createState() => _AddTableState();
}

class _AddTableState extends State<AddTable> {
  final _addtable = GlobalKey<FormState>();
  final _nameclass = TextEditingController();
  final _codeclass = TextEditingController();
  final _teacher = TextEditingController();
  final _startclass = TextEditingController();
  final _endclass = TextEditingController();
  final _details = TextEditingController();
  final _days = TextEditingController();
  final store = FirebaseFirestore.instance;

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
          title: Text('Add subject in ' + globalDay),
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
                                child: Text('?????????????????????????????????'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  onChooseImage(1);
                                },
                                child: Text('?????????????????????'),
                              ),
                            ],
                          )
                        : Image.file(_avatar!),
                    SizedBox(
                      height: 10,
                    ),
                    //  daysBox(),
                    nameclassBox(),
                    codeclassBox(),
                    teacherBox(),
                    startclassBox(),
                    endclassBox(),
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
            'color': 4282231104,
            'image': await uploadurl,
            'subj_name': _nameclass.text,
            'subj_code': _codeclass.text,
            'teacher_name': _teacher.text,
            'start_time': _startclass.text,
            'end_time': _endclass.text,
            'details': _details.text,
            'place': '???????????????????????????',
          };

          try {
            DocumentReference ref = await store
                .collection('studee')
                .doc(uid)
                .collection('timetable1')
                .doc('timetable')
                .collection(globalDay)
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
      controller: _nameclass,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: '???????????????????????? :',
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
      controller: _codeclass,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: '???????????????????????? :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }

  TextFormField teacherBox() {
    return TextFormField(
      controller: _teacher,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: '????????????????????? :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }

  TextFormField startclassBox() {
    return TextFormField(
      controller: _startclass,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: '??????????????????????????? :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }

  TextFormField endclassBox() {
    return TextFormField(
      controller: _endclass,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: '????????????????????????????????? :',
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
        labelText: '?????????????????????????????? :',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }
/*
  TextFormField daysBox() {
    return TextFormField(
      controller: _days,
      // keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: '????????? :',
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter text';
        }
        return null;
      },
    );
  }*/
}

// DropdownButton setday(){
//   return DropdownButton( items: const[
//   DropdownMenuItem(child: Text("monday"),value: "monday"),
//   DropdownMenuItem(child: Text("tuesday"),value: "tuesday"),
//   DropdownMenuItem(child: Text("wednesday"),value: "wednesday"),
//   DropdownMenuItem(child: Text("thurday"),value: "thurday"),
//   DropdownMenuItem(child: Text("friday"),value: "friday"),
//   DropdownMenuItem(child: Text("saturday"),value: "saturday"),
//   DropdownMenuItem(child: Text("sunday"),value: "sunday"),

//   ]
// }
//   DropdownButton setday(){
//      return DropdownButton<String>(
//   items: <String>['A', 'B', 'C', 'D'].map((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(value),
//     );
//   }).toList(),
//   onChanged: (_) {},
// );
//   }
////final
///
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

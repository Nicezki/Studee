import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class Addtable1 extends StatefulWidget {
  const Addtable1({Key? key}) : super(key: key);
  @override
  State<Addtable1> createState() => _AddtableState();
}

class _AddtableState extends State<Addtable1> {
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
          title: Text('เพิ่มชั้นเรียน'),
        ),
        body: Container(
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
                    classBox(),
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
}

TextFormField nameBox() {
  return TextFormField(
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
      labelText: 'หัวข้อ :',
    ),
  );
}

TextFormField classBox() {
  return TextFormField(
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
      labelText: 'วิชา :',
    ),
  );
}

TextFormField messageBox() {
  return TextFormField(
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
      labelText: 'ข้อความ :',
    ),
  );
}

TextFormField tageBox() {
  return TextFormField(
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
      labelText: 'แท็ก :',
    ),
  );
}

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
    onPressed: () async {},
  );
}

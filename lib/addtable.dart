import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class Addtable extends StatefulWidget {
  const Addtable({super.key});
  

  @override
  State<Addtable> createState() => _AddtableState();
}

class _AddtableState extends State<Addtable> {
  File? _avatar;

  onChooseImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: ImageSource.camera);

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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                     children: <Widget>[
                        _avatar == null
                        ? ElevatedButton(onPressed: () {
                          onChooseImage();
                        },child: const Text('ใส่รูปภาพ'),
                        )
                        : Image.file(_avatar!),

                        buildNameclassField(),
                        buildCodeclassField(),
                        buildTeachernameField(),
                        buildStartclssField(),
                        buildEndclssField(),
                        buildDetailsField(),
                          SizedBox(
                            height: 10,
                          ),
                        buildRegisterButton(),
                    ],
                    
                  )),
            )
            ),
            color: Color.fromARGB(255, 255, 255, 255),));
  }
}

TextFormField buildNameclassField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'ชื่อวิชา :',
       
      ),
    );
  }

  TextFormField buildCodeclassField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'รหัสวิชา :',
        
      ),
    );
  }

  TextFormField buildTeachernameField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'อาจารย์ :',
        
      ),
    );
  }

  TextFormField buildStartclssField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'เวลาเริ่ม :',
       
      ),
    );
  }

TextFormField buildEndclssField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'เวลาสิ้นสุด :',
        
      ),
    );
  }

  TextFormField buildDetailsField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'รายละเอียด :',
        
      ),
    );
  }

   ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: Container(
            child: Center(child:
                   Column(mainAxisSize: MainAxisSize.min,
                   children: <Widget>[
                   Text("บันทึก", style: TextStyle(fontSize: 20)),
                   
                      ],)),),
      onPressed: () async {
      
      },
    );
  }
  

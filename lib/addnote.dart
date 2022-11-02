import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);
  

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
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
          title: Text('เพิ่มบันทึก'),
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
                        buildMessageField(),
                        buildTageField(),
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
        labelText: 'หัวข้อ :',
       
      ),
    );
  }

  TextFormField buildCodeclassField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'รายวิชา :',
        
      ),
    );
  }

  TextFormField buildMessageField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'ข้อความ :',
        
      ),
    );
  }

  TextFormField buildTageField() {
    return TextFormField(
      
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'แท็ก :',
       
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
  

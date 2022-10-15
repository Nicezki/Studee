import 'package:flutter/material.dart';


void main() => runApp(AddSchedule());

class AddSchedule extends StatefulWidget {
 AddSchedule({Key? key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule>{
   Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.book),
          title: Text('เพิ่มโน๊ต'),
          
          
          
          
        ),
        body: Container(
            child: Center(
              child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                        buildTitleField(),
                        buildCourseField(),
                        buildMessageField(),
                        buildTagsField(),
                        buildRegisterButton(),
                    ],
                    
                  )),
            ),
            color: Color.fromARGB(255, 255, 255, 255),));
                          
                  

    }
}

TextFormField buildTitleField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'หัวข้อ :',
       
      ),
    );
  }
TextFormField buildCourseField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'รายวิชา :',
       
      ),
    );
  }

  TextFormField buildMessageField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'ข้อความ :',
       
      ),
    );
  }

  TextFormField buildTagsField() {
    return TextFormField(
      obscureText: true,
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

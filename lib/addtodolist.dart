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
          title: Text('เพิ่มสิ่งที่ต้องทำ'),
          
          
          
          
        ),
        body: Container(
            child: Center(
              child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                        buildTitleField(),
                        buildSubjectField(),
                        buildStartDateField(),
                        buildEndDateField(),
                        buildDetailsField(),
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
        labelText: 'หัวข้องาน :',
       
      ),
    );
  }

  TextFormField buildSubjectField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'วิชา :',
       
      ),
    );
  }

  TextFormField buildStartDateField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'วันที่สั่ง :',
       
      ),
    );
  }

   TextFormField buildEndDateField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'วันที่ส่ง :',
       
      ),
    );
  }

  TextFormField buildDetailsField() {
    return TextFormField(
      obscureText: true,
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

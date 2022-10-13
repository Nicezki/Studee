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
          title: Text('เพิ่มชั้นเรียน'),
          
          
          
          
        ),
        body: Container(
            child: Center(
              child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                        buildNameclassField(),
                        buildCodeclassField(),
                        buildTeachernameField(),
                        buildStartclssField(),
                        buildEndclssField(),
                        buildDetailsField(),
                        buildRegisterButton(),
                    ],
                    
                  )),
            ),
            color: Color.fromARGB(255, 255, 255, 255),));
                          
                  

    }
}

TextFormField buildNameclassField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'ชื่อวิชา :',
       
      ),
    );
  }

  TextFormField buildCodeclassField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'รหัสวิชา :',
        
      ),
    );
  }

  TextFormField buildTeachernameField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'อาจารย์ :',
        
      ),
    );
  }

  TextFormField buildStartclssField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'เวลาเริ่ม :',
       
      ),
    );
  }

TextFormField buildEndclssField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'เวลาสิ้นสุด :',
        
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

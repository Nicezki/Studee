import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 255, 230),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
      key: _formstate,
      child: ListView(
          children: <Widget>[
            SizedBox(height: 25),
            Icon(
              Icons.app_registration_rounded,
              size: 100,),
            SizedBox(height: 25),
            Text(
              'Register Now!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            SizedBox(height: 20),
            buildNameField(),
            buildEmailField(),
            buildPasswordField(),
            SizedBox(height: 10),
            buildRegisterButton(),
          ],
      ),
    ),
        ));
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: const Text('Register'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        elevation: MaterialStateProperty.all(15),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )
        )
      ),
      onPressed: () async {
        print('Regis new Account');
        if (_formstate.currentState!.validate()) print(email.text);
        print(password.text);
        final _user = await auth.createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
        _user.user!.sendEmailVerification();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            ModalRoute.withName('/'));
        addUserDetails(
          name.text.trim(),
          _user
        );
        addUserCollection(
          _user
        );
      },
    );
  }


    Future addUserDetails(String name,var user) async {
    await FirebaseFirestore.instance.collection('studee').doc(user.user!.uid).set({
      'name': name,
    });
  }

    Future addUserCollection(var user) async {
    await FirebaseFirestore.instance.collection('studee').doc(user.user!.uid).collection('timetable1').doc();
    await FirebaseFirestore.instance.collection("studee").doc(user.user!.uid).collection('timetable1').doc('info').set({
      'name': 'ตารางเรียนเริ่มต้น',
    });
    await FirebaseFirestore.instance.collection("studee").doc(user.user!.uid).collection('timetable1').doc('note').collection('1').doc().set({
      'color': 4282231104,
      'details': "โน้ตสุดโปรด",
      'title': "note สุดยอดเยี่ยมของคุณอยู่ที่นี่แล้ว ลองแก้ไขดูสิ",
      "type": "Lecture",
      "image" : "https://timeoutcomputers.com.au/wp-content/uploads/2016/12/noimage.jpg"
    });
    var days = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'];
    days.forEach((String days) => FirebaseFirestore.instance.collection("studee").doc(user.user!.uid).collection('timetable1').doc('timetable')
    .collection(days).doc().set({
      "subj_name" : "Mobile Device Programming",
      "subj_code": "00123456",
      "teacher_name" : "นชิรัตน์ ราชบุรี",
      "start_time": "09:00",
      "end_time": "12:00",
      "place": "32100",
      "image": "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
      "details": "วิชาที่ยอดเยี่ยม อาจารย์สอนดีมาก",
      "color": 4282231104
    }));
    await FirebaseFirestore.instance.collection("studee").doc(user.user!.uid).collection('timetable1').doc('todolist').collection('1').doc().set({
      "title": "ทำงาน App ส่งอาจารย์",
      "subj_code": "00123456",
      "details": "ทำงานกลุ่มส่งอาจารย์",
      "status": "in-progress",
      "image": "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
      "color": 4282231104,
      "start" : "2022-09-25 10:00:00",
      "end" : "2022-11-04 13:39:59"
    });
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: password,
      validator: (value) {
        if (value!.length < 8)
          return 'Please Enter more than 8 Character';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Password',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        if (value!.isEmpty)
          return 'Please fill in E-mail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
        hintText: 'SteveNojobs@RMUTT.ac.th',
      ),
    );
  }
  TextFormField buildNameField() {
    return TextFormField(
      controller: name,
      validator: (value) {
        if (value!.isEmpty)
          return 'Please fill in name';
        else
          return null;
      },
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Name',
        icon: Icon(Icons.person),
        hintText: 'Steve Nojobs',
      ),
    );
  }
}

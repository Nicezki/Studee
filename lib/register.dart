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
        body: Form(
      key: _formstate,
      child: ListView(
        children: <Widget>[
          buildNameField(),
          buildEmailField(),
          buildPasswordField(),
          buildRegisterButton(),
        ],
      ),
    ));
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: const Text('Register'),
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
      'color': "#FF0000",
      'details': "เขียน note ที่นี่",
      'title': "note สุดยอดเยี่ยมของคุณ",
      "type": "Lecture",
    });
    var days = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'];
    days.forEach((String days) => FirebaseFirestore.instance.collection("studee").doc(user.user!.uid).collection('timetable1').doc('timetable')
    .collection(days).doc().set({
      "subj_name" : "Mobile Device Programming",
      "subj_code": "00123456",
      "start_time": "09:00",
      "end_time": "12:00",
      "place": "32100",
      "image": "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
      "details": "วิชาที่ยอดเยี่ยม อาจารย์สอนดีมาก",
      "color": "#FF0000"
    }));
    await FirebaseFirestore.instance.collection("studee").doc(user.user!.uid).collection('timetable1').doc('todolist').collection('1').doc().set({
      "title": "ทำงาน App ส่งอาจารย์",
      "subj_code": "00123456",
      "details": "ทำงานกลุ่มส่งอาจารย์",
      "status": "in-progress",
      "image": "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
      "color": "#FF0000",
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

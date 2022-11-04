import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studee/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //if already login then go to home page
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        //snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('เข้าสู่ระบบอยู่แล้ว คุณจะถูกนำไปยังหน้าหลัก'),
          ),
        );
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }
  final _formstate = GlobalKey<FormState>();
  String? email;
  String? password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 255, 230),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formstate,
      child: ListView(
          children: <Widget>[
            SizedBox(height: 25),
            Icon(
              Icons.school_rounded,
              size: 100,),
            SizedBox(height: 25),
            Text(
              'Studee',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Best app for student.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            emailTextFormField(),
            passwordTextFormField(),
            SizedBox(height: 10),
            loginButton(),
            SizedBox(height: 10),
            registerButton(context),
          ],
      ),
      ),
        ),
    );
  }

  ElevatedButton registerButton(BuildContext context) {
    return ElevatedButton(
      // ignore: prefer_const_constructors
      child: Text('Register new account',
      style: TextStyle(fontSize: 14)
      ),
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
      onPressed: () {
        print('ไปยังหน้า Register');
        Navigator.pushNamed(context, '/RegisterPage');
      },
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
        child: Text(
        "Log in",
        style: TextStyle(fontSize: 14)
      ),
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
          if (_formstate.currentState!.validate()) {
            print('Valid Form');
            _formstate.currentState!.save();
            try {
              await auth
                  .signInWithEmailAndPassword(
                      email: email!, password: password!)
                  .then((value) {
                if (value.user!.emailVerified) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("เข้าสู่ระบบสำเร็จ")));
                  Navigator.pushNamed(context, '/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("กรุณายืนยันอีเมล")));
                }
              }).catchError((reason) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("อีเมลหรือรหัสผ่านไม่ถูกต้อง")));
              });
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          } else
            print('Invalid Form');
        });
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      onSaved: (value) {
        password = value!.trim();
      },
      validator: (value) {
        if (value!.length < 8)
          return 'Please Enter more than 8 character';
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

  TextFormField emailTextFormField() {
    return TextFormField(
      onSaved: (value) {
        email = value!.trim();
      },
      validator: (value) {
        if (!validateEmail(value!))
          return 'Please fill in E-mail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
        hintText: 'student1@rmutt.ac.th',
      ),
    );
  }

  bool validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return (!regex.hasMatch(value)) ? false : true;
  }
}

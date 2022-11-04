import 'package:studee/main.dart';
import 'package:studee/tabtail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/test.dart';
import 'package:studee/variable.dart';




class MyApp extends StatelessWidget {
  final String title;
  const MyApp({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
      appBar: AppBar(
        title: const Text('Studee'),
        centerTitle: true,
        
        
        /*actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    cur_page == 0
                        ? "/add_SecondPage"
                        : cur_page == 1
                            ? "/add_SecondPage2"
                            : cur_page == 2
                                ? "/add_SecondPage3"
                                : "/");
              })
        ],*/
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: defaultAppColorTheme,
            ),
            accountName: userFullName,
            accountEmail: Text(user?.email.toString() ?? "No User"),
          ),
          ListTile(
            title: const Text('ออกจากระบบ',
                style: TextStyle(color: Colors.red)),
            onTap: () {
              logoutUser();
              Navigator.pushNamed(context, '/LoginPage');
            },
          ),
        ],
      )),
    );
  }
}



import 'package:studee/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';

class add_SecondPage extends StatelessWidget {
  const add_SecondPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add time-table'),
      ),
      body: Center(child: Text('Add time-table here')),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: const TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return Column(
                children: [
                  Container(),
                  SizedBox(height: 6),
                  Container(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.735,
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 10),
                            child: Row(children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(209, 189, 189, 189),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://www.techhub.in.th/wp-content/uploads/2021/05/577280151-1.jpg'))),
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color:
                                          Color.fromARGB(209, 189, 189, 189)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Text("tee888 Go Go Go"),
                                        Text(
                                            "Good game, pays hard, pays quickly."),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("B:50"),
                                            Text("A:99"),
                                            Text("money:9999"),
                                            IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/view_subject');
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          );
                        }),
                  )
                ],
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}

import 'package:studee/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';

class add_SecondPage2 extends StatelessWidget {
  const add_SecondPage2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
      ),
      body: Center(child: Text('Add note here')),
    );
  }
}

class MyStatelessWidget2 extends StatelessWidget {
  const MyStatelessWidget2({Key? key}) : super(key: key);
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
        return StreamBuilder(
            stream: store
                .collection('studee')
                .doc('newst1')
                .collection('timetable1')
                .doc('notes')
                .collection('1')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Scaffold(
                body: snapshot.hasData
                    ? TabBarView(
                        children: tabs.map((Tab tab) {
                          return Column(
                            children: [
                              Container(),
                              SizedBox(height: 6),
                              Container(),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    //shrinkWrap: true,
                                    itemCount: snapshot.data!.size,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var model =
                                          snapshot.data!.docs.elementAt(index);
                                      var results = Map<String, dynamic>.from(
                                          model.data() as Map);
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 10),
                                        child: Row(children: [
                                          Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromARGB(
                                                    209, 189, 189, 189),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      results['image']),
                                                )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 100,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                  ),
                                                  color: Color.fromARGB(
                                                      209, 189, 189, 189)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      results['title'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      results['details'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "เริ่ม : " +
                                                          results['start'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "จบ : " +
                                                              results['end'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        IconButton(
                                                            icon: const Icon(
                                                                Icons.add),
                                                            onPressed: () {
                                                              ID = snapshot
                                                                      .data!.docs
                                                                      .elementAt(
                                                                          index)
                                                                  as String;
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/view_subject');
                                                            })
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
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            });
      }),
    );
  }
}

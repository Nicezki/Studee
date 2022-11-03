import 'package:studee/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';

class add_SecondPage3 extends StatelessWidget {
  const add_SecondPage3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task'),
      ),
      body: Center(child: Text('Add task here')),
    );
  }
}

class MyStatelessWidget3 extends StatelessWidget {
  const MyStatelessWidget3({Key? key}) : super(key: key);
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
                .doc(uid)
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
                                            width: 125,
                                            height: 125,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20)),
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
                                              height: 125,
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
                                                    Text(
                                                      "จบ : " + results['end'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                            icon: const Icon(Icons
                                                                .document_scanner_sharp),
                                                            onPressed: () {
                                                              ID = snapshot
                                                                  .data!.docs
                                                                  .elementAt(
                                                                      index)
                                                                  .id as String;
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/view_note');
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

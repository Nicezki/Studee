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
        /*appBar: AppBar(
            toolbarHeight: 0,
            bottom: const TabBar(
              tabs: tabs,
            ),
          ),*/
        return StreamBuilder(
            /*  stream: store
                .collection('studee')
                .doc(uid)
                .collection('timetable1')
                .doc('timetable')
                .collection(day)
                .snapshots(),*/
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
              body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: DefaultTabController(
                length: 7,
                child: Scaffold(
                  /*appBar: AppBar(
                    flexibleSpace: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(text: 'Monday'),
                        Tab(text: 'Tuesday'),
                        Tab(text: 'Wednesday'),
                        Tab(text: 'Thursday'),
                        Tab(text: 'Friday '),
                        Tab(text: 'Saturday'),
                        Tab(text: 'Sunday'),
                      ],
                    ),
                  ),*/
                  body: TabBarView(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: snapshot.hasData
                            ? TabBarView(
                                children: tabs.map((Tab tab) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 6),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.735,
                                        child: ListView.builder(
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            //shrinkWrap: true,
                                            itemCount: snapshot.data!.size,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              day = "monday";
                                              var model = snapshot.data!.docs
                                                  .elementAt(index);
                                              var results =
                                                  Map<String, dynamic>.from(
                                                      model.data() as Map);
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 10),
                                                child: Row(children: [
                                                  Container(
                                                    width: 125,
                                                    height: 125,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                        20)),
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
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                          color: Color.fromARGB(
                                                              209,
                                                              189,
                                                              189,
                                                              189)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              results[
                                                                  'subj_name'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              results[
                                                                  'details'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              "เริ่ม : " +
                                                                  results[
                                                                      'start_time'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              "จบ : " +
                                                                  results[
                                                                      'end_time'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .document_scanner_sharp),
                                                                    onPressed:
                                                                        () {
                                                                      ID = snapshot
                                                                          .data!
                                                                          .docs
                                                                          .elementAt(
                                                                              index)
                                                                          .id as String;
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
                      ),
                      Tab(icon: Icon(Icons.settings)),
                      Tab(icon: Icon(Icons.dynamic_feed)),
                      Tab(icon: Icon(Icons.settings)),
                      Tab(icon: Icon(Icons.dynamic_feed)),
                      Tab(icon: Icon(Icons.settings)),
                      Tab(icon: Icon(Icons.dynamic_feed)),
                    ],
                  ),
                ),
              ),
            ),
          ));
        });
      }),
    );
  }
}

aaar(String day5) {
  return StreamBuilder(
    stream: store
        .collection('studee')
        .doc(uid)
        .collection('timetable1')
        .doc('timetable')
        .collection(day5)
        .snapshots(),
  );
}

/*
child: snapshot.hasData
                                ? TabBarView(
                                    children: tabs.map((Tab tab) {
                                      return Column(
                                        children: [
                                          Container(),
                                          SizedBox(height: 6),
                                          Container(),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.735,
                                            child: ListView.builder(
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                //shrinkWrap: true,
                                                itemCount: snapshot.data!.size,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var model = snapshot
                                                      .data!.docs
                                                      .elementAt(index);
                                                  var results =
                                                      Map<String, dynamic>.from(
                                                          model.data() as Map);
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 10),
                                                    child: Row(children: [
                                                      Container(
                                                        width: 125,
                                                        height: 125,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            20)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        209,
                                                                        189,
                                                                        189,
                                                                        189),
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(
                                                                      results[
                                                                          'image']),
                                                                )),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: 125,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            20),
                                                                  ),
                                                                  color: Color
                                                                      .fromARGB(
                                                                          209,
                                                                          189,
                                                                          189,
                                                                          189)),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  results[
                                                                      'subj_name'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  results[
                                                                      'details'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  "เริ่ม : " +
                                                                      results[
                                                                          'start_time'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  "จบ : " +
                                                                      results[
                                                                          'end_time'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    IconButton(
                                                                        icon: const Icon(Icons
                                                                            .document_scanner_sharp),
                                                                        onPressed:
                                                                            () {
                                                                          ID = snapshot
                                                                              .data!
                                                                              .docs
                                                                              .elementAt(index)
                                                                              .id as String;
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
*/

/*  body: snapshot.hasData
                    ? TabBarView(
                        children: tabs.map((Tab tab) {
                          return Column(
                            children: [
                              Container(),
                              SizedBox(height: 6),
                              Container(),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.735,
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
                                                      results['subj_name'],
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
                                                          results['start_time'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "จบ : " +
                                                          results['end_time'],
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
                      ),*/
Future<void> Monday() async {
  Monday();
}

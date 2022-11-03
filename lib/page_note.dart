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
        title: const Text('Add time-table'),
      ),
      body: Center(child: Text('Add time-table here')),
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
          if (!tabController.indexIsChanging) {}
        });
        return Container(
            child: Scaffold(
          body: createTimeTableView('1'),
        ));
      }),
    );
  }

  Container createTimeTableView(String dayname) {
    //return Container of steambuilder firebase data in card
    return Container(
      child: StreamBuilder(
          stream: store
              .collection('studee')
              .doc(uid)
              .collection('timetable1')
              .doc('note')
              .collection(dayname)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    //shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      //card with im
                      return Card(
                          child: InkWell(
                        onTap: () {
                          ID = snapshot.data!.docs.elementAt(index).id;
                          Day = dayname;
                          Navigator.pushNamed(context, '/view_note');
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 10),
                              child: Row(children: [
                                Container(
                                  width: 125,
                                  height: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    color: Color.fromARGB(233, 233, 233, 233),
                                    /*  image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(ds['image']),
                                      )*/
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 125,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color:
                                            Color.fromARGB(233, 233, 233, 233)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Title :" + ds['title'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "Type :" + ds['type'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "Details :" + ds['details'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                      )
                          /*ListTile(
                          leading: Icon(Icons.car_rental),
                          title: Text(ds['subj_name']),
                          subtitle: Text(ds['details']),
                        ),*/
                          );
                    })
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

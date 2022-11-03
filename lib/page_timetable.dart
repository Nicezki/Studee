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
        return Container(
            child: Scaffold(
                  appBar: AppBar(
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
                  ),
                  body: TabBarView(
                    children: [
                      createTimeTableView('monday'),
                      createTimeTableView('tuesday'),
                      createTimeTableView('wednesday'),
                      createTimeTableView('thursday'),
                      createTimeTableView('friday'),
                      createTimeTableView('saturday'),
                      createTimeTableView('sunday'),
                    ],
                  ),
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
            .doc('timetable')
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
                        child: ListTile(
                          title: Text(ds['subj_name']),
                          subtitle: Text(ds['details']),
                        ),
                      );
                    })
                : Center(child: CircularProgressIndicator());
          }),
    );
    
  }

}
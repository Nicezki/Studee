import 'package:studee/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';
import 'package:studee/view_subject.dart';
import 'package:tab_container/tab_container.dart';

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

class MyStatelessWidget1 extends StatelessWidget {
  const MyStatelessWidget1({Key? key}) : super(key: key);
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, '/add_SecondPage');
            },
            autofocus: true,
            icon: const Icon(Icons.add),
            label: const Text('ADD'),
            backgroundColor: Color.fromARGB(255, 4, 188, 16),
          ),
          appBar: AppBar(
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 40.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6)),
            ),
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
                          margin: EdgeInsets.all(14.0),
                          child: InkWell(
                            highlightColor: Colors.blue.withOpacity(0.4),
                            splashColor: Color.fromARGB(255, 255, 81, 249)
                                .withOpacity(0.5),
                            focusColor: Color.fromARGB(255, 0, 255, 64)
                                .withOpacity(0.6),
                            onTap: () {
                              ID = snapshot.data!.docs.elementAt(index).id;
                              Day = dayname;
                              Navigator.of(context).push(_createRoute());
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5, left: 5, right: 5, bottom: 5),
                                  child: Row(children: [
                                    Container(
                                      width: 125,
                                      height: 125,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                          color: Color.fromARGB(
                                              233, 233, 233, 233),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(ds['image'] ??
                                                "https://timeoutcomputers.com.au/wp-content/uploads/2016/12/noimage.jpg"),
                                          )),
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
                                            color: Color.fromARGB(
                                                233, 233, 233, 233)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                ds['subj_name'],
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                ds['details'],
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                ds['start_time'],
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                ds['end_time'],
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

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SubjectDetail(ID),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
/*
Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
  double x = 150, y = 45, r = 0.5;
  Path path = Path()
    ..addRRect(RRect.fromRectAndCorners(rect))
    ..moveTo(rect.bottomRight.dx - 30, rect.bottomCenter.dy)
    ..relativeQuadraticBezierTo(
        ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * r, y * r)
    ..relativeQuadraticBezierTo(
        -x / 6 * r, y * (1 - r), -x / 2 * (1 - r), y * (1 - r))
    ..relativeQuadraticBezierTo(
        ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * (1 - r), -y * (1 - r))
    ..relativeQuadraticBezierTo(-x / 6 * r, -y * r, -x / 2 * r, -y * r);
  path.close();
  return path;
}*/
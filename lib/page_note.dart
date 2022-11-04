import 'package:studee/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/variable.dart';
import 'package:studee/view_notes.dart';

class add_SecondPage2 extends StatelessWidget {
  const add_SecondPage2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorTheme,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          backgroundColor: backgroundColorTheme,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, '/add_SecondPage2');
            },
            autofocus: true,
            icon: const Icon(Icons.add),
            label: const Text('เพิ่ม'),
            backgroundColor: Color.fromARGB(255, 4, 188, 16),
          ),
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
                          margin: EdgeInsets.all(14.0),
                          child: InkWell(
                            highlightColor: Color.fromARGB(255, 151, 211, 159)
                                .withOpacity(0.4),
                            splashColor: Color.fromARGB(255, 0, 255, 34)
                                .withOpacity(0.5),
                            focusColor: Color.fromARGB(255, 255, 153, 0)
                                .withOpacity(0.6),
                            onTap: () {
                              ID = snapshot.data!.docs.elementAt(index).id;
                              Day = dayname;
                              Navigator.of(context).push(_createRoute());
                            },
                            onLongPress: () {
                              ID = snapshot.data!.docs.elementAt(index).id;
                              Day = dayname;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('ลบรายวิชา'),
                                      content: const Text(
                                          'คุณต้องการลบรายวิชานี้ใช่หรือไม่'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('ไม่ใช่'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            store
                                                .collection('studee')
                                                .doc(uid)
                                                .collection('timetable1')
                                                .doc('note')
                                                .collection(dayname)
                                                .doc(ID)
                                                .delete();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('ลบ'),
                                        ),
                                      ],
                                    );
                                  });
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
                                        color:
                                            Color.fromARGB(233, 233, 233, 233),
                                        /* image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(ds['image'] ??
                                            "https://timeoutcomputers.com.au/wp-content/uploads/2016/12/noimage.jpg"),
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
                                            color: Color.fromARGB(
                                                233, 233, 233, 233)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
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

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NoteDetail(ID),
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

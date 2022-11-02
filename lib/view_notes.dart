import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studee/edit_subject.dart';

class NoteDetail extends StatefulWidget {
  final String _idi; //if you have multiple values add here
  const NoteDetail(this._idi, {Key? key})
      : super(key: key); //add also..example this.abc,this...

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  String note_title = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String _id = widget._idi;
    return StreamBuilder(
        stream: getSubject(_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("ข้อมูลบันทึก "+note_title),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    //send map of data to edit page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditItem(
                            Map<String,dynamic>.from(snapshot.data!.docs[0].data() as Map)
                          )));
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: snapshot.hasData
                ? SafeArea(child: buildSubjectList(snapshot.data!))
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

  // ListView buildSubjectList(QuerySnapshot data) {
  //   return ListView.builder(
  //     itemCount: data.docs.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       // var model = data.docs.elementAt(index);
  //       //user_id.data.timetable1.data.timetable.monday[0].subj_name
  //       var model = data.docs.elementAt(index);
  //       String a = model['subj_name'] + '  ' + model['subj_code'];
  //       return ListTile(
  //         title: Text(model['subj_name']),
  //         //    subtitle: Text(model['detail'] + Text("${model['price']}")),
  //         subtitle: Text(a),
  //         trailing: ElevatedButton(
  //             child: const Text('Delete'),
  //             onPressed: () {
  //               print(model.id);
  //       //deleteValue(model.id);
  //               //Navigator.pop(context);
  //             }),
  //       );
  //     },
  //   );
  // }

  Container buildSubjectList(QuerySnapshot data) {
    var model = data.docs.elementAt(0);
    var results = Map<String, dynamic>.from(model.data() as Map);
    note_title = results['title'];
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(results['image']),
              radius: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              results['title'],
              style: TextStyle(height: 1, fontSize: 36),
            ),
            DataTable(columns: [
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
            ], rows: [
              DataRow(cells: [
                DataCell(Text('เริ่ม')),
                DataCell(Text(results['subj_code'])),
              ]),
              DataRow(cells: [
                DataCell(Text('สิ้นสุด')),
                DataCell(Text(results['start'])),
              ]),
              DataRow(cells: [
                DataCell(Text('สิ้นสุดใน')),
                DataCell(Text(results['end'])),
              ]),
            ]),
          ]),
        ],
      ),
    );
  }

  //Future<void> deleteValue(String titleName) async {
  //  await _firestore
  //      .collection('books')
  //      .doc(titleName)
  //      .delete()
  //      .catchError((e) {
  //    print(e);
  //  });
  //}

  // Stream<QuerySnapshot> getSubject(String subj_code) {
  //   return _firestore
  //       //user_id.data.timetable1.data.timetable.monday[0].subj_code
  //       ///studee/newst1/timetable1/timetable/monday
  //       .collection('studee')
  //       .doc('newst1')
  //       .collection('timetable1')
  //       .doc('timetable')
  //       .collection('monday')
  //       .where('subj_code', isEqualTo: subj_code)
  //       .snapshots();
  //   }

  Stream<QuerySnapshot> getSubject(String doc_id) {
    return _firestore
        //user_id.data.timetable1.data.timetable.monday[0].subj_code
        ///studee/newst1/timetable1/timetable/monday
        .collection('studee')
        .doc('newst1')
        .collection('timetable1')
        .doc('notes')
        .collection('1')
        .where(FieldPath.documentId, isEqualTo: doc_id)
        .snapshots();
  }
}

  // Stream<QuerySnapshot> getSubject(String subj_code) {
  //   final studeeRef = _firestore.collection("studee");
  //   final userRef = studeeRef.doc('testuser');
  //   final dataRef = userRef.collection('data');
  //   final timetable1Ref = dataRef.doc('timetable1');
  //   final data2Ref = timetable1Ref.collection('data');
  //   final timetableRef = data2Ref.doc('timetable');
  //   return timetableRef
  //       //user_id.data.timetable1.data.timetable.monday[0].subj_code
  //       .collection('monday')
  //       // .doc('testuser')
  //       // .collection('data')
  //       // .doc('timetable1')
  //       // .collection('data')
  //       // .doc('timetable')
  //       // .collection('monday')
  //       .where('subj_code', isEqualTo: subj_code)
  //       .snapshots();
  //   }
        
  

  //Query Collecton Group 'monday' from Firestore
  // void testQuery() {
  //   final studeeRef = _firestore.collection("studee");
  //   final userRef = studeeRef.doc('testuser');
  //   final dataRef = userRef.collection('data');
  //   final timetable1Ref = dataRef.doc('timetable1');
  //   final data2Ref = timetable1Ref.collection('data');
  //   final timetableRef = data2Ref.doc('timetable');
  //   final mondayRef = timetableRef.collection('monday');
  //   mondayRef.get().then((QuerySnapshot querySnapshot) => {
  //         querySnapshot.docs.forEach((doc) {
  //           print(doc["subj_name"]);
  //         })
  //       });
  // }
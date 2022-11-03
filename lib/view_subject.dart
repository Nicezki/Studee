import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studee/edit_subject.dart';
import 'package:studee/variable.dart';

class SubjectDetail extends StatefulWidget {
  final String _idi; //if you have multiple values add here
  const SubjectDetail(this._idi, {Key? key})
      : super(key: key); //add also..example this.abc,this...

  @override
  _SubjectDetailState createState() => _SubjectDetailState();
}

class _SubjectDetailState extends State<SubjectDetail> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String _id = widget._idi;
    return StreamBuilder(
        stream: getSubject(Day,uid,_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("รายละเอียดตารางเรียน"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    //send map of data to edit page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditSubject(
                            _id,
                            Map<String,dynamic>.from(snapshot.data!.docs[0].data() as Map)
                          )));
                  },
                  icon: const Icon(Icons.edit),
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
    var results = Map();
    try{
    var model = data.docs.elementAt(0);
    results = Map<String, dynamic>.from(model.data() as Map);
    }catch(e){
      results = {
          "subj_name" : "ไม่มีข้อมูล",
          "subj_code": "ไม่มีข้อมูล",
          "start_time": "00:00",
          "end_time": "01:00",
          "place": "ไม่มีข้อมูล",
          "image": "https://timeoutcomputers.com.au/wp-content/uploads/2016/12/noimage.jpg",
          "details": "ไม่มีข้อมูล",
          "teacher_name" : "ไม่มีข้อมูล",
          "color": "#000000"
        };
    }
    // return Container(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       Column(children: [
    //         SizedBox(
    //           height: 20,
    //         ),
    //         CircleAvatar(
    //           backgroundImage: NetworkImage(results['image']),
    //           radius: 100,
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         // Flexible(child: Text(results['subj_name'],style: TextStyle(fontSize: 36),maxLines: 8,softWrap: true,overflow: TextOverflow.ellipsis,)),
            
    //         DataTable(columns: [
    //           DataColumn(label: Text('')),
    //           DataColumn(label: Text('')),
    //         ], rows: [
    //           DataRow(cells: [
    //             DataCell(Text('รหัสวิชา')),
    //             DataCell(Text(results['subj_code'])),
    //           ]),
    //           DataRow(cells: [
    //             DataCell(Text('ชื่อวิชา')),
    //             DataCell(Text(results['subj_name'])),
    //           ]),
    //           // DataRow(cells: [
    //           //   DataCell(Text('ชื่ออาจารย์')),
    //           //   DataCell(Text(results['teacher_name'])),
    //           // ]),
    //           DataRow(cells: [
    //             DataCell(Text('ห้องเรียน')),
    //             DataCell(Text(results['place'])),
    //           ]),
    //           DataRow(cells: [
    //             DataCell(Text('รายละเอียด')),
    //             DataCell(Text(results['details'])),
    //           ]),
    //           DataRow(cells: [
    //             DataCell(Text('เวลาเริ่มเรียน')),
    //             DataCell(Text(results['start_time'])),
    //           ]),
    //           DataRow(cells: [
    //             DataCell(Text('เวลาสิ้นสุด')),
    //             DataCell(Text(results['end_time'])),
    //           ]),
    //         ]),
    //       ]),
    //     ],
    //   ),
    // );
    //display as card with circle avatar with handled overflow as safearea
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
            // Flexible(child: Text(results['subj_name'],style: TextStyle(fontSize: 36),maxLines: 8,softWrap: true,overflow: TextOverflow.ellipsis,)),
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: DataTable(columns: [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ], rows: [
                  DataRow(cells: [
                    DataCell(Text('รหัสวิชา')),
                    DataCell(Text(results['subj_code'])),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('ชื่อวิชา')),
                    DataCell(Text(results['subj_name'])),
                  ]),
                  // DataRow(cells: [
                  //   DataCell(Text('ชื่ออาจารย์')),
                  //   DataCell(Text(results['teacher_name'])),
                  // ]),
                  DataRow(cells: [
                    DataCell(Text('ห้องเรียน')),
                    DataCell(Text(results['place'])),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('รายละเอียด')),
                    DataCell(Text(results['details'])),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('เวลาเริ่มเรียน')),
                    DataCell(Text(results['start_time'])),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('เวลาสิ้นสุด')),
                    DataCell(Text(results['end_time'])),
                  ]),
                ]),
              ),
            ),
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

  Stream<QuerySnapshot> getSubject(String thisday,String user,String docId) {
    print(docId);
    print(user);
    print(thisday);

    return _firestore
        //user_id.data.timetable1.data.timetable.monday[0].subj_code
        ///studee/newst1/timetable1/timetable/monday
        .collection('studee')
        .doc(user)
        .collection('timetable1')
        .doc('timetable')
        .collection(thisday)
        .where(FieldPath.documentId, isEqualTo: docId)
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
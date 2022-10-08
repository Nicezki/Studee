import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubjectDetail extends StatefulWidget {
  final String _idi; //if you have multiple values add here
  SubjectDetail(this._idi,{Key? key})
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
        stream: getSubject(_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Subject Details"),
            ),
            body: snapshot.hasData
                ? buildSubjectList(snapshot.data!)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

  ListView buildSubjectList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.docs.length,
      itemBuilder: (BuildContext context, int index) {
        // var model = data.docs.elementAt(index);
        //user_id.data.timetable1.data.timetable.monday[0].subj_name
        var model = data.docs.elementAt(index);
        String a = model['detail'] + '  ' + model['price'].toString();
        return ListTile(
          title: Text(model['title']),
          //    subtitle: Text(model['detail'] + Text("${model['price']}")),
          subtitle: Text(a),
          trailing: ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                print(model.id);
        //deleteValue(model.id);
                //Navigator.pop(context);
              }),
        );
      },
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

  Stream<QuerySnapshot> getSubject([String subj_code='00123456']) {
    // Firestore _firestore = Firestore.instance;
    return _firestore
        //user_id.data.timetable1.data.timetable.monday[0].subj_name
        .collection('studee')
        .where('subj_code', isEqualTo: subj_code)
        .snapshots();
    }
        
  }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studee/edit_note.dart';
import 'package:studee/variable.dart';

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
        stream: getSubject(uid,_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appColorTheme,
              title: Text("บันทึก "+note_title),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    //send map of data to edit page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNote(
                            _id,
                            Map<String,dynamic>.from(snapshot.data!.docs[0].data() as Map)
                          )));
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            body: snapshot.hasData
                ? SafeArea(child: buildNoteList(snapshot.data!))
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

  // ListView buildNoteList(QuerySnapshot data) {
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

  Container buildNoteList(QuerySnapshot data) {
    var model = data.docs.elementAt(0);
    var results = Map<String, dynamic>.from(model.data() as Map);
    note_title = results['title'];
    appColorTheme = Color(int.parse(results['color'].substring(1, 7), radix: 16) +
        0xFF000000);
    
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
              backgroundImage: NetworkImage(results['image']?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
              radius: 100,
            ),
            SizedBox(
              height: 20,
            ),
             Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                //card with note title and details
                child: 
                Column(
                  children: [
                    Text(results['title'],style: TextStyle(fontSize: 28,),),
                  ],
                ),

              ),
            ),
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                //card with note title and details
                child: 
                Column(
                  children: [
                    Text(results['details'],style: TextStyle(fontSize: 20),),
                  ],
                ),

              ),
            ),
          ]),
        ],
      ),
    );
  }


  Stream<QuerySnapshot> getSubject(String user,String docId) {
    print(docId);
    print(user);
    return _firestore
        .collection('studee')
        .doc(user)
        .collection('timetable1')
        .doc('note')
        .collection('1')
        .where(FieldPath.documentId, isEqualTo: docId)
        .snapshots();
  }
}
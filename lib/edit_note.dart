import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  Map<String,dynamic> shoppingItem;
  EditNote (this.shoppingItem,{Key? key}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote>{
  late TextEditingController _controllerName;
  late TextEditingController _controllerDetails;
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController(text: widget.shoppingItem['subj_name']);
    _controllerDetails = TextEditingController(text: widget.shoppingItem['details']);
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Form(
        key: key,
        child: ListView(
          children: [
            buildNameField(),
            buildDetailsField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }


  TextFormField buildNameField() {
    return TextFormField(
      controller: _controllerName,
      decoration: InputDecoration(
        labelText: 'Name',
        icon: Icon(Icons.book),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill name in blank';
        } else {
          return null;
        }
      },
    );
  }

  


  TextFormField buildDetailsField() {
    return TextFormField(
      controller: _controllerDetails,
      decoration: InputDecoration(
        labelText: 'Details',
        icon: Icon(Icons.details),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill details in blank';
        } else {
          return null;
        }
      },
    );
  }

  

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (key.currentState!.validate()) {
          FirebaseFirestore.instance
              .collection('shopping')
              .doc(widget.shoppingItem['id'])
              .update({
            'name': _controllerName.text,
            'details': _controllerDetails.text,
          }).then((value) => Navigator.pop(context));
        }
      },
      child: Text('Save'),
    );
  }

  @override

  void dispose() {
    _controllerName.dispose();
    _controllerDetails.dispose();
    super.dispose();
  }

}

//   initState() {
//     super.initState();
//     _controllerCode = TextEditingController(text: Widget.shoppingItem['Code']);
//     _controllerName = TextEditingController(text: Widget.shoppingItem['Name']);
//     _controllerTeacher = TextEditingController(text: Widget.shoppingItem['Teacher']);
//     _controllerPlace = TextEditingController(text: Widget.shoppingItem['Place']);
//     _controllerDetails = TextEditingController(text: Widget.shoppingItem['Details']);
//     _controllerStart = TextEditingController(text: Widget.shoppingItem['Start']);
//     _controllerEnd = TextEditingController(text: Widget.shoppingItem['End']);
//   }

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text('Edit an item'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(key: key,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _controllerCode,
//               decoration: 
//               InputDecoration(hintText: 'Enter the Subject Code'),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Please enter the Subject Code';
//                 }

//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _controllerName,
//               decoration: 
//               InputDecoration(hintText: 'Enter the Subject name'),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Please enter the Subject name';
//                 }

//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _controllerTeacher,
//               decoration: 
//               InputDecoration(hintText: 'Enter Teacher Name'),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Please enter Teacher Name';
//                 }

//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _controllerPlace,
//               decoration: 
//               InputDecoration(hintText: 'Enter the Place'),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Please enter the Place';
//                 }

//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _controllerDetails,
//               decoration: 
//               InputDecoration(hintText: 'Enter the Details'),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Please enter the Detalis';
//                 }

//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _controllerStart,
//               decoration: 
//               InputDecoration(hintText: 'Enter the Start time'),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Please enter the Start time';
//                 }

//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _controllerEnd,
//               decoration: 
//               InputDecoration(hintText: 'Enter the End time'),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Please enter the End time';
//                 }

//                 return null;
//               },
//             ),
//             ElevatedButton(
//               onPressed: () async{
//                 if (key.currentState!.validate()){
//                   Map<String, String> dataToUpdate ={
//                     'subj_code':_controllerCode.text,
//                     'subj_name':_controllerName.text,
//                     'teacher_name':_controllerTeacher.text,
//                     'place':_controllerPlace.text,
//                     'details':_controllerDetails.text,
//                     'start_time':_controllerStart.text,
//                     'end_time':_controllerEnd.text,
//                   };
//                   CollectionReference collection = FirebaseFirestore.instance.collection('studee');
//                   DocumentReference document = collection.doc(Widget.shoppingItem['doc_id']);
//                   document.update(dataToUpdate);
//                 }
//               },
//               child: Text('Submit'))
//           ],
//         ),
//         ),
//       ),
//     );
//   }
// }
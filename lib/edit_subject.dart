import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditItem extends StatefulWidget {
  Map<String,dynamic> shoppingItem;
  EditItem(this.shoppingItem,{Key? key}) : super(key:key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem>{
  late TextEditingController _controllerCode;
  late TextEditingController _controllerName;
  late TextEditingController _controllerTeacher;
  late TextEditingController _controllerPlace;
  late TextEditingController _controllerDetails;
  late TextEditingController _controllerStart;
  late TextEditingController _controllerEnd;
  GlobalKey<FormState> key = GlobalKey();

  initState() {
    super.initState();
    _controllerCode = TextEditingController(text: widget.shoppingItem['Code']);
    _controllerName = TextEditingController(text: widget.shoppingItem['Name']);
    _controllerTeacher = TextEditingController(text: widget.shoppingItem['Teacher']);
    _controllerPlace = TextEditingController(text: widget.shoppingItem['Place']);
    _controllerDetails = TextEditingController(text: widget.shoppingItem['Details']);
    _controllerStart = TextEditingController(text: widget.shoppingItem['Start']);
    _controllerEnd = TextEditingController(text: widget.shoppingItem['End']);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('Edit an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(key: key,
        child: Column(
          children: [
            TextFormField(
              controller: _controllerCode,
              decoration: 
              InputDecoration(hintText: 'Enter the Subject Code'),
              validator: (String? value){
                if (value == null || value.isEmpty){
                  return 'Please enter the Subject Code';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _controllerName,
              decoration: 
              InputDecoration(hintText: 'Enter the Subject name'),
              validator: (String? value){
                if (value == null || value.isEmpty){
                  return 'Please enter the Subject name';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _controllerTeacher,
              decoration: 
              InputDecoration(hintText: 'Enter Teacher Name'),
              validator: (String? value){
                if (value == null || value.isEmpty){
                  return 'Please enter Teacher Name';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _controllerPlace,
              decoration: 
              InputDecoration(hintText: 'Enter the Place'),
              validator: (String? value){
                if (value == null || value.isEmpty){
                  return 'Please enter the Place';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _controllerDetails,
              decoration: 
              InputDecoration(hintText: 'Enter the Details'),
              validator: (String? value){
                if (value == null || value.isEmpty){
                  return 'Please enter the Detalis';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _controllerStart,
              decoration: 
              InputDecoration(hintText: 'Enter the Start time'),
              validator: (String? value){
                if (value == null || value.isEmpty){
                  return 'Please enter the Start time';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _controllerEnd,
              decoration: 
              InputDecoration(hintText: 'Enter the End time'),
              validator: (String? value){
                if (value == null || value.isEmpty){
                  return 'Please enter the End time';
                }

                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async{
                if (key.currentState!.validate()){
                  Map<String, String> dataToUpdate ={
                    'subj_code':_controllerCode.text,
                    'subj_name':_controllerName.text,
                    'teacher_name':_controllerTeacher.text,
                    'place':_controllerPlace.text,
                    'details':_controllerDetails.text,
                    'start_time':_controllerStart.text,
                    'end_time':_controllerEnd.text,
                  };
                  CollectionReference collection = FirebaseFirestore.instance.collection('studee');
                  DocumentReference document = collection.doc(Widget.shoppingItem['doc_id']);
                  document.update(dataToUpdate);
                }
              },
              child: Text('Submit'))
          ],
        ),
        ),
      ),
    );
  }
}
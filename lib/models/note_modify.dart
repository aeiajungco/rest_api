// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  const NoteModify({Key? key, this.noteID}) : super(key: key);

  final String? noteID;
  bool get isEditing => noteID != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Create note' : 'Edit Note')),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Note title'),
          ),
          Container(height: 8),
          TextField(
            decoration: InputDecoration(hintText: 'Note content'),
          ),
          Container(height: 16),
          SizedBox(
            width: double.infinity,
            height: 35,
            child: TextButton(
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {
                if (isEditing) {

                }
                else {
                  
                }
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

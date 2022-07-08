// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/models/note.dart';
import 'package:rest_api/services/notes_service.dart';

class NoteModify extends StatefulWidget {
  const NoteModify({Key? key, this.noteID}) : super(key: key);

  final String? noteID;

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.I<NotesService>();
  String? errorMessage;
  Note? note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });

    notesService.getNote(widget.noteID!).then((response) {
      setState(() {
        _isLoading = false;
      });

      if (response.error!) {
        errorMessage = response.errorMessage ?? 'An error occurred.';
      }
      note = response.data;
      _titleController.text = note!.noteTitle!;
      _contentController.text = note!.noteContent!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Note title'),
                  ),
                  Container(height: 8),
                  TextField(
                    controller: _contentController,
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
                        } else {}
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

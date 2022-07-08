import 'dart:convert';
import 'package:rest_api/models/api_response.dart';
import 'package:rest_api/models/notes_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': 'a954f9fb-fedb-4bab-b2ac-131e7eb8b0ee'};

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse(API + '/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(
              noteID: item['noteID'],
              noteTitle: item['noteTitle'],
              createDateTime: DateTime.parse(item['createDateTime']),
              latestEditDateTime: item['latestEditDateTime'] != null
                  ? DateTime.parse(item['latestEditDateTime'])
                  : null);
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(
          data: notes,
        );
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'An error occured'));
  }
}

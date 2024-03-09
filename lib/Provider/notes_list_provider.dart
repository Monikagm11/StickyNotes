import 'package:flutter/material.dart';

class NotesListProvider extends ChangeNotifier {
  String _noteEditId = "";

  List<Map<String, dynamic>> notes = [
    // {
    //   'id': '1',
    //   'title': 'Swim',
    //   'description': 'I need to go swimming to reduce weight'
    // },
    // {
    //   'id': "2",
    //   'title': 'Run',
    //   'description':
    //       'I need to go running to improve endurance I need to go running to improve endurance I need to go running to improve endurance'
    // },
    // {
    //   'id': "3",
    //   'title': 'Study',
    //   'description': 'I need to study for my upcoming exam'
    // },
    // {
    //   'id': "4",
    //   'title': 'Sleep',
    //   'description':
    //       'I need to get enough sleep for better health I need to get enough sleep for better health I need to get enough sleep for better health'
    // },
  ];

  set setEditID(String id) {
    _noteEditId = id;
  }

  String get getEditId {
    return _noteEditId;
  }

  void addNotes(note) {
    notes.add(note);
    notifyListeners();
  }

  void deleteNotes(id) {
    notes.removeWhere((note) => note['id'] == id);
    notifyListeners();
  }

  void editNotes(title, description, editId, imagePath) {
    for (int index = 0; index < notes.length; index++) {
      if (notes[index]["id"] == editId) {
        notes[index]["title"] = title;
        notes[index]["description"] = description;
        notes[index]["imgPath"] = imagePath;
      }
    }
    notifyListeners();
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotes/Provider/notes_list_provider.dart';
import 'package:stickynotes/Screens/write_notes.dart';


class ShowFullNotes extends StatelessWidget {
  final String id, title, description, imgPath;

  const ShowFullNotes(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.imgPath});
  static const routeName = "/show_full_notes";

  @override
  Widget build(BuildContext context) {
    void deleteNote(String id) {
      Provider.of<NotesListProvider>(context, listen: false).deleteNotes(id);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sticky",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () => deleteNote(id),
            icon: const Icon(Icons.delete_forever_rounded),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              const SizedBox(height: 10),
              if (imgPath != "")
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<NotesListProvider>(context, listen: false)
                        .setEditID = id;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const WriteNotes()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

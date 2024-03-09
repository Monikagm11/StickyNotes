import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stickynotes/Provider/notes_list_provider.dart';
import 'package:stickynotes/Screens/home.dart';
import 'package:stickynotes/Widgets/notes_form.dart';
import 'package:uuid/uuid.dart';

class WriteNotes extends StatefulWidget {
  const WriteNotes({super.key});

  static const routeName = "/write_notes";

  @override
  State<WriteNotes> createState() => _WriteNotesState();
}

class _WriteNotesState extends State<WriteNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  String imagePath = "";
  String toEditImagePath = "";

  void saveNotes(context, title, description, editId) {
    if (editId != "") {
      if (imagePath.isEmpty && toEditImagePath.isNotEmpty) {
        imagePath = toEditImagePath;
      }

      Provider.of<NotesListProvider>(context, listen: false)
          .editNotes(title, description, editId, imagePath);
      Provider.of<NotesListProvider>(context, listen: false).setEditID = "";
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
    } else {
      Provider.of<NotesListProvider>(context, listen: false).addNotes({
        "id": const Uuid()
            .v4(), //Here, Uuid package is used to create a universally unique id
        "title": title,
        "description": description,
        "imgPath": imagePath
      });
    }
    setState(() {
      imagePath = "";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Notes Saved",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //This is done to pass the title, description value into the tesxtbox while performing edit

    NotesListProvider notesProvider =
        Provider.of<NotesListProvider>(context, listen: false);
    String editId = notesProvider.getEditId;
    String savedImagePath = "";

    Future<void> pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      savedImagePath = File(image.path).path;
      setState(() {
        imagePath = savedImagePath;
      });
    }

    if (editId != "") {
      for (int index = 0; index < notesProvider.notes.length; index++) {
        if (notesProvider.notes[index]["id"] == editId) {
          title =
              TextEditingController(text: notesProvider.notes[index]['title']);
          description = TextEditingController(
              text: notesProvider.notes[index]['description']);
          toEditImagePath = notesProvider.notes[index]['imgPath'];
        }
      }
    }
    //

    return Scaffold(
        appBar: AppBar(
          title: const Text("Sticky",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).primaryColorLight,
        ),
        body: Column(
          children: [
            notesForm(context, title, description),
            ListTile(
              title: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => pickImage(),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: imagePath.isEmpty && toEditImagePath.isEmpty
                          ? const Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.teal,
                            )
                          : imagePath.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(toEditImagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            ElevatedButton(
              onPressed: () {
                if (title.text != "" ||
                    description.text != "" ||
                    imagePath != "") {
                  saveNotes(context, title.text, description.text, editId);
                  title.clear();
                  description.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Fill atleast one field",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 198, 7, 7),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
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
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ));
  }
}

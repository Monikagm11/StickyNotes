import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotes/Provider/notes_list_provider.dart';
import 'package:stickynotes/Screens/show_full_notes.dart';
import 'package:stickynotes/Screens/write_notes.dart';
import 'package:stickynotes/Widgets/home_gridview_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class Home extends StatelessWidget {
  const Home({super.key});
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sticky",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Consumer<NotesListProvider>(
        builder: (context, notesProvider, child) => notesProvider.notes.isEmpty
            ? const Center(
                child: Text(
                  "You don't have any notes!!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              :MasonryGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                itemCount: notesProvider.notes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ShowFullNotes(
                              id: notesProvider.notes[index]['id'],
                              title: notesProvider.notes[index]['title'],
                              description: notesProvider.notes[index]
                                  ['description'],
                              imgPath: notesProvider.notes[index]['imgPath'],
                            ),
                          ),
                        );
                      },
                      child: homeGridviewCard(context, notesProvider, index));
                },
              ),
            // : GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2),
            //     itemCount: notesProvider.notes.length,
            //     itemBuilder: ((context, index) {
            //       return GestureDetector(
            //           onTap: () {
            //             Navigator.of(context).push(
            //               MaterialPageRoute(
            //                 builder: (context) => ShowFullNotes(
            //                   id: notesProvider.notes[index]['id'],
            //                   title: notesProvider.notes[index]['title'],
            //                   description: notesProvider.notes[index]
            //                       ['description'],
            //                   imgPath: notesProvider.notes[index]['imgPath'],
            //                 ),
            //               ),
            //             );
            //           },
            //           child: homeGridviewCard(context, notesProvider, index));
            //     })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<NotesListProvider>(context, listen: false).setEditID = "";
          Navigator.of(context).pushNamed(WriteNotes.routeName);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Theme.of(context).primaryColorLight,
        child: const Icon(Icons.add),
      ),
    );
  }
}

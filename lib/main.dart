import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotes/Provider/notes_list_provider.dart';
import 'package:stickynotes/Screens/home.dart';
import 'package:stickynotes/Screens/write_notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesListProvider(),
      child: MaterialApp(
        title: 'Sticky',
        theme: ThemeData(
          primaryColorLight: Colors.teal,
          primaryColorDark: const Color.fromARGB(255, 49, 46, 46),
          fontFamily: 'Quicksand',
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const Home(),
        routes: {
          Home.routeName: (context) => const Home(),
          WriteNotes.routeName: (context) => const WriteNotes(),
        },
      ),
    );
  }
}

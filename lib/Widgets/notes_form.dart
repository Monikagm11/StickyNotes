import 'package:flutter/material.dart';

Widget notesForm(context, title, description) {
  return Flexible(
    child: ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(
            "Title",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ListTile(
          title: TextField(
            controller: title,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).primaryColorDark,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            "Note",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ListTile(
          title: TextField(
            maxLines: 5,
            controller: description,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).primaryColorDark,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

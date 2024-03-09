import 'package:flutter/material.dart';

Widget homeGridviewCard(context, notesProvider, index) {
  //If the description length is more than 82, this function truncates the length of the description
  String truncateDescription(String description) {
    if (description.length > 82) {
      return "${description.substring(0, 82)}...";
    } else {
      return description;
    }
  }

  return Card(
    color: Theme.of(context).primaryColorDark,
    margin: const EdgeInsets.all(12),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notesProvider.notes[index]['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              notesProvider.notes[index]['imgPath'] != ""
                  ? const Icon(
                      Icons.image_rounded,
                      color: Colors.teal,
                    )
                  : Container()
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            truncateDescription(notesProvider.notes[index]['description']),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}

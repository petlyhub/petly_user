import 'package:flutter/material.dart';

class TextUploadNoteWidget extends StatelessWidget {
  final String title;
  const TextUploadNoteWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
    );
  }
}

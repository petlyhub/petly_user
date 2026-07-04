import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget vehicleImageItem({
  required String title,
  required XFile? file,
  required VoidCallback onPick,
  required VoidCallback onRemove,
}) {
  return Expanded(
    child: Column(
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(color: Colors.black),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onPick,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: file == null
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, size: 30),
                        SizedBox(height: 5),
                        Text('Upload'),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(file.path),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: onRemove,
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ],
    ),
  );
}
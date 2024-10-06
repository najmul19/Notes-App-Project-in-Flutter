import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/widget/app_background_widget.dart';


class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleEditingController = TextEditingController();
  final descriptionController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  bool isButtonEnabled() {
    return titleEditingController.text.isNotEmpty && descriptionController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
            onPressed: isButtonEnabled()
                ? () {
              firestore.collection("notes").add({
                "title": titleEditingController.text,
                "description": descriptionController.text,
              }).then((value) {
                print("Data added");
                titleEditingController.clear();
                descriptionController.clear();
                setState(() {}); // Refresh the UI after clearing inputs
              }).catchError((error) => print("Failed to add note: $error"));
            }
                : null, // Disable the button when fields are empty
            child: const Text("Save"),
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonEnabled() ? Colors.white54 : Colors.grey, // Change color based on enabled/disabled
            ),
          ),
          const SizedBox(width: 10),
        ],
        title: const Text(
          'Add New Note',
          style: TextStyle(
            fontSize: 24, // Size of the text
            fontWeight: FontWeight.bold, // Makes the text bold
            color: Colors.deepPurple, // Text color
            letterSpacing: 1.2, // Spacing between letters
          ),
        ),
        centerTitle: true,
      ),
      body: AppBackgroundWidget( // Keeping the original background widget
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70),
              TextField(
                controller: titleEditingController,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.deepPurple),
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: "Title",
                  contentPadding: EdgeInsets.all(16),
                ),
                onChanged: (text) {
                  setState(() {}); // Update UI when text changes
                },
              ),
              TextField(
                controller: descriptionController,
                maxLines: 1500,
                decoration: const InputDecoration(
                  labelText: "Description",
                  contentPadding: EdgeInsets.all(16),
                ),
                onChanged: (text) {
                  setState(() {}); // Update UI when text changes
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

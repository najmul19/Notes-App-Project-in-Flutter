import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:notes/widget/app_background_widget.dart';


class UpdateNoteScreen extends StatefulWidget {
  UpdateNoteScreen({super.key, required this.title, required this.description, required this.id});
  final String title;
  final String description;
  final dynamic id;

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final titleEditingController = TextEditingController();
  final descriptionController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    titleEditingController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  bool isButtonEnabled() {
    return titleEditingController.text.isNotEmpty && descriptionController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
            onPressed: isButtonEnabled()
                ? () {
              firestore.collection("notes").doc(widget.id).update({
                "title": titleEditingController.text,
                "description": descriptionController.text,
              }).then((value) {
                print("Note updated");
                Get.back();
              }).catchError((error) => print("Failed to update note: $error"));
            }
                : null, // Disable the button when fields are empty
            child: const Text("Update"),
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonEnabled() ? Colors.white54 : Colors.grey, // Change color based on enabled/disabled
            ),
          ),
          const SizedBox(width: 10),
        ],
        title: const Text(
          'Update Note',
          style: TextStyle(
            fontSize: 24, // Size of the text
            fontWeight: FontWeight.bold, // Makes the text bold
            color: Colors.deepPurple, // Text color
            letterSpacing: 1.2, // Spacing between letters
          ),
        ),
        centerTitle: true,
      ),
      body: AppBackgroundWidget(
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

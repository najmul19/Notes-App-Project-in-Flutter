
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/application/app.dart';
import 'firebase_options.dart'; // Ensure you have this generated file if you're using it

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use this if you generated firebase_options.dart
  );

  runApp(NoteApp());
}



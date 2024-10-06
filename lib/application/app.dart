import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/screen/home_screen.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note App",
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    );
  }
}
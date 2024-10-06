import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notes/screen/add_note_screen.dart';
import 'package:notes/screen/update_note_screen.dart';
import 'package:notes/widget/app_background_widget.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Your Notes',
          style: TextStyle(
            fontSize: 24, // Size of the text
            fontWeight: FontWeight.bold, // Makes the text bold
            color: Colors.deepPurple, // Text color
            letterSpacing: 1.2, // Spacing between letters
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackgroundWidget( child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("notes").snapshots(), //instance create
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) { // if there's an error
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) { // while fetching data
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc["title"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const Divider(),
                        Text(doc["description"]),
                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      titlePadding: const EdgeInsets.only(top: 16, left: 16),
                                      title: const Text("Alert"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Divider(height: 0),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.to(UpdateNoteScreen(
                                                title: doc["title"],
                                                description: doc["description"],
                                                id: doc.id,
                                              ));
                                            },
                                            child: Row(
                                              children: [
                                                const Text("Edit"),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons.edit)),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                              firestore.collection("notes").doc(doc.id).delete().then((onValue) {
                                                print("Data Deleted");
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                const Text("Delete"),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons.delete)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(bottom: 4.0),
                                child: Icon(Icons.more_vert_rounded),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          );
        },
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNoteScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
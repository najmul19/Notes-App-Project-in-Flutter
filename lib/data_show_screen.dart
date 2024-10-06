import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class DataShowScreen extends StatelessWidget {
  const DataShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DataShowScreen"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
            if(snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            } if(snapshot.connectionState==ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){

                  var doc = snapshot.data!.docs[index];

                  return ListTile(
                    leading: IconButton(onPressed: (){
                      Clipboard.setData(ClipboardData(text: doc["name"]));//coppy
                    }, icon: const Icon(Icons.copy)),
                    title: Text("name: ${doc["name"]}"),
                    subtitle: Text("age: ${doc["age"]}"),
                    trailing: IconButton(onPressed: (){
                      Share.share('check out my website https://example.com');
                    }, icon: const Icon(Icons.share)),
                  );
            });
          },
      ),
    );
  }
}

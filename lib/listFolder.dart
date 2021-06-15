import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'displayImages.dart';

class ListFolder extends StatefulWidget {
  @override
  _ListFolderState createState() => _ListFolderState();
}

class _ListFolderState extends State<ListFolder> {
  List images = [];
  List update = [];
  void initState() {
    getImages();
    super.initState();
  }

  getImages() {
    var collectionRef = FirebaseFirestore.instance.collection('Images');
    final value = collectionRef;
    value.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        images.add(result.data());
        setState(() {
          update = images;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Folders'),
        ),
        body: ListView.builder(
            itemCount: update.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: new Center(child: Text(update[index]['name'])),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DisplayImages(
                            folder: update[index]['name'],
                            images: [],

                          ),
                        ));
                  },
                ),
              );
            }));
  }
}

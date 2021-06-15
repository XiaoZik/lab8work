import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'details.dart';
import 'moveFolder.dart';

//import 'package:lab8work/ListModel.dart';
List images = [];
List update = [];

class DisplayImages extends StatefulWidget {
  final String folder;
  final List images;
  const DisplayImages({
    Key key,
    @required this.folder,
    this.images,
  }) : super(key: key);
  @override
  _DisplayImagesState createState() =>
      _DisplayImagesState(folder: this.folder, images: this.images);
}

class _DisplayImagesState extends State<DisplayImages> {
  String folder;
  List images;
  _DisplayImagesState({this.folder, this.images});
  @override
  void initState() {
    getImages();
    super.initState();
  }

  getImages() {
    var collectionRef = FirebaseFirestore.instance.collection("Images");
    final value = collectionRef.doc(folder).collection("Folder");
    value.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        images.add(result.data());
        setState(() {
          update = images;
        });
      });
    });
    print(update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Images'),
        ),
        body: ListView.builder(
            itemCount: update.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: new Center(child: Text(update[index]['description'])),
                  subtitle: Column(
                    children: <Widget>[
                      Text(update[index]['date']),
                      TextButton(
                          style:
                              TextButton.styleFrom(backgroundColor: Colors.red),
                          child: Text(
                            'Delete',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              update.removeAt(index);
                            });
                          }),
                      TextButton(
                          style:
                              TextButton.styleFrom(backgroundColor: Colors.red),
                          child: Text(
                            'Move',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MoveFolder(
                                    url: update[index]['url'],
                                    name: update[index]['name'],
                                    description: update[index]['description'],
                                    date: update[index]['date'],
                                    lat: update[index]['latitude'],
                                    long: update[index]['longitude'],
                                  ),
                                ));
                          })
                    ],
                  ),
                  leading: Image.network(
                    update[index]['url'].toString(),
                    fit: BoxFit.fill,
                  ),
                  trailing: Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                              description: update[index]['description'],
                              url: update[index]['url'].toString(),
                              date: update[index]['date'],
                              longitude: update[index]['longitude'],
                              latitude: update[index]['latitude']),
                        ));
                  },
                ),
              );
            }));
  }
}

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

var imageName = "";
String desc = "";
String folder = "";
String key = "";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Upload Image',
      home: HomePage(),
    );
  }
}

class GetText {
  static retrieveText(file) {
    imageName = file;
  }
}

class GetKey {
  static getKey() {
    return key;
  }
}

class SetKey {
  static setKey(String newValue) {
    key = newValue;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // TextField controller
  final _textController = TextEditingController();
  final _folderController = TextEditingController();
  // This function is triggered when the "Write" buttion is pressed
  Future<void> _writeData() async {
    desc = _textController.text;
    folder = _folderController.text;

    //Map<String, dynamic> data = {"description": "$desc"};
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    var lat = position.latitude;
    var long = position.longitude;
    Map<String, dynamic> myData = new Map();
    myData['test'] = folder;
    myData['test2'] = desc;
    myData['test3'] = formattedDate;
    myData['test4'] = lat;
    myData['test5'] = long;
    //CollectionReference collectionReference =
    //  FirebaseFirestore.instance.collection('$folder');
    //collectionReference.add(data);
    Navigator.pop(context, myData);
    // final destination = 'files/$imageName/Description';
    //_writeDataDateTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter Description'),
            ),
            TextField(
              controller: _folderController,
              decoration: InputDecoration(labelText: 'Enter Folder Name'),
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: _writeData,
            ),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}

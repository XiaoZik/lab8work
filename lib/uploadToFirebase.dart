import 'dart:io';
import 'package:lab8work/descriptions.dart';
import 'package:lab8work/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lab8work/listFolder.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    title: 'Firebase Storage Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: UploadingImageToFirebaseStorage(),
  ));
}

final Color green = Colors.brown;
final Color orange = Colors.brown;
var fileName = "";
String url = "";
List images = [];
List update = [];

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File _imageFile;
  List images;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future _openGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future _openCamera() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  directToFirebase(BuildContext context) async {
    Map<String, dynamic> myData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
    uploadImageToFirebase(context, myData['test'], myData['test2'],
        myData['test3'], myData['test4'], myData['test5']);
  }

  Future uploadImageToFirebase(BuildContext context, String cloudFolderName,
      String desc, String date, double lat, double long) async {
    fileName = basename(_imageFile.path);
    final destination = '$fileName';
    FirebaseApi api = new FirebaseApi();
    api.uploadFile(destination, _imageFile, context, folder, cloudFolderName,
        desc, date, lat, long);
    FirebaseApi.getText(fileName);
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(250.0),
                    bottomRight: Radius.circular(10.0)),
                gradient: LinearGradient(
                    colors: [green, orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Uploading Image to Firebase Storage",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: SingleChildScrollView(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Column(
                                children: [
                                  _imageFile != null
                                      ? Image.file(
                                          _imageFile,
                                          width: 450,
                                          height: 400,
                                        )
                                      : TextButton(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: Colors.blue,
                                            size: 50,
                                          ),
                                          onPressed: _openCamera,
                                        ),
                                  _imageFile != null
                                      ? Image.file(_imageFile)
                                      : TextButton(
                                          child: Icon(
                                            Icons.add_photo_alternate_rounded,
                                            color: Colors.blue,
                                            size: 50,
                                          ),
                                          onPressed: _openGallery,
                                        ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              margin: const EdgeInsets.only(
                  top: 30, left: 20.0, right: 20.0, bottom: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => directToFirebase(context),
                        child: Text(
                          "Upload Image",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: ElevatedButton(
                            child: Text('Display Folders'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ListFolder(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        )
      ],
    ));
  }
}
/*
if request.auth != null*/

import 'package:flutter/material.dart';
import 'firebase_api.dart';
import 'uploadToFirebase.dart';

class MoveFolder extends StatelessWidget {
  final String url;
  final String name;
  final String cloudFolderName = '';
  final String description;
  final String date;
  final String lat;
  final String long;
  MoveFolder({
    Key key,
    @required this.url,
    this.name,
    this.description,
    this.date,
    this.lat,
    this.long,
  }) : super(key: key);
  final _folderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Move to other folder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _folderController,
              decoration: InputDecoration(labelText: 'Enter Folder Name'),
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                FirebaseApi api = new FirebaseApi();
                api.uploadFile1(url, name, _folderController.text, description,
                    date, lat, long);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UploadingImageToFirebaseStorage(),
                  ),
                );
              },
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

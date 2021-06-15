import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String description;
  final String url;
  final String date;
  final String longitude;
  final String latitude;
  final String beforeLocation = "Location";
  final String beforeDescription = "Description";
  final String beforeDate = "Date";
  String get finalLocation => '$beforeLocation' + " : " + '$longitude' +", "+'$latitude';
  String get finalDescription => '$beforeDescription' + " : " + '$description';
  String get finalDate => '$beforeDate' + " : " + '$date';
  Details(
      {Key key,
      @required this.description,
      this.url,
      this.date,
      this.longitude,
      this.latitude})
      : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                url,
                height: 500,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  finalDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  finalDate,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  finalLocation,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

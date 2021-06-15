import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lab8work/descriptions.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  var storage = FirebaseStorage.instance;
  void uploadFile(
      String destination,
      File file,
      BuildContext context,
      String folder,
      String cloudFolderName,
      String desc,
      String date,
      double lat,
      double long) async {
    TaskSnapshot snapshot =
        await storage.ref().child("$destination").putFile(file);
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    Map<String, dynamic> data = {
      "name": "$cloudFolderName",
      "url": "$downloadUrl",
      "description": "$desc",
      "date": "$date",
      "latitude": "$lat",
      "longitude": "$long"
    };
    Map<String, dynamic> data1 = {
      "name": "$cloudFolderName"
    };
    //CollectionReference collectionReference =
    //  FirebaseFirestore.instance.collection('$cloudFolderName');
    //collectionReference.add(data);
    /*FirebaseFirestore.instance
        .collection('Images')
        .doc('$cloudFolderName')
        .update(data);*/
    var collectionRef = FirebaseFirestore.instance.collection("Images");
    var doc = await collectionRef.doc("$cloudFolderName").get();
    if (doc.exists) {
      await FirebaseFirestore.instance
          .collection('Images')
          .doc('$cloudFolderName')
          .collection("Folder")
          .add(data);
    } else {
      await FirebaseFirestore.instance
          .collection('Images')
          .doc('$cloudFolderName')
          .collection("Folder")
          .add(data);
    }
    FirebaseFirestore.instance
        .collection('Images')
        .doc('$cloudFolderName')
        .set(data1);
    
    return null;
  }

  void uploadFile1(
      String destination,
      String downloadUrl,
      String cloudFolderName,
      String desc,
      String date,
      String lat,
      String long) async {
    Map<String, dynamic> data = {
      "name": "$downloadUrl",
      "url": "$destination",
      "description": "$desc",
      "date": "$date",
      "latitude": "$lat",
      "longitude": "$long"
    };
    Map<String, dynamic> data1 = {
      "name": "$cloudFolderName"
    };
    var collectionRef = FirebaseFirestore.instance.collection("Images");
    var doc = await collectionRef.doc("$cloudFolderName").get();
    if (doc.exists) {
      await FirebaseFirestore.instance
          .collection('Images')
          .doc('$cloudFolderName')
          .collection("Folder")
          .add(data);
    } else {
      await FirebaseFirestore.instance
          .collection('Images')
          .doc('$cloudFolderName')
          .collection("Folder")
          .add(data);
    }
    FirebaseFirestore.instance
        .collection('Images')
        .doc('$cloudFolderName')
        .set(data1);
    
    return null;
  }

  static UploadTask uploadText(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static getText(var file) {
    GetText.retrieveText(file);
  }
}



import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class UploadPhoto extends StatefulWidget {
  UploadPhoto() : super();

  @override
  _UploadPhotoState createState() => _UploadPhotoState();

}

class _UploadPhotoState extends State<UploadPhoto> {
  bool _init = false;
  bool _error = false;
  CollectionReference images;
  Image image;
  List documents = [];
  List<String> imageNames;


  Future<void> initFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _init = true;
      });
    } catch (e) {
      _error = true;
    }

  }
  Future<void> uploadImage() async {
    int i = 1;
    String name = 'image$i';
    bool loopBool = true;
    FilePickerResult picked = await FilePicker.platform.pickFiles();
    if (picked != null) {
      Uint8List imgData = picked.files.single.bytes;
      setState(() {
        image = Image.memory(imgData);
      });
      /*while (loopBool) {
        images.doc(name).get().then((d) => {
        if(!d.exists) {
          images.doc(name).set({'data': imgData}).then((value) =>
          print('uploaded')).catchError((error) => 'failed to upload').then((loopBool) => loopBool = false)

        } else {
            i++
        }
      });}*/ //todo fix check
    }}

  Future<void> viewImage() async {
    DocumentSnapshot doc = await images.doc('image1').get();
    Map<String,dynamic> img = doc.data();

    List imgdata = img.values.toList();

    imgdata = imgdata[0].cast<int>();

    Uint8List imgData = Uint8List.fromList(imgdata);
    setState(() {
      image = Image.memory(imgData);
    });
  }

  void clearImage() {
    setState(() {
      image = null;
    });
  }

  @override
  void initState() {
    initFirebase();
    super.initState();
    print('a');
  }



  @override
  Widget build(BuildContext context) {
    if (_error) {
      print("help");
    }

    if (_init) {
      print("loaded");
    }

    String dropdownValue = 'image1';
    images = FirebaseFirestore.instance.collection('images');
    print(images);
    void updateImageNames () {
      for (int i=1; i<=this.documents.length;i++) {
        imageNames[i] = "image$i";
        print(imageNames[i]);
      }
    }
    Future<void> getDocuments() async {
      QuerySnapshot querySnapshot = await images.get();
      this.documents = querySnapshot.docs.map((doc) => doc.data()).toList();
      //TODO: add dropdown menu and update the items in it on build
      //updateImageNames();


    }
    getDocuments();




    return Scaffold(
        body: Column(
          children: [
            RawMaterialButton(
              fillColor: Theme
                  .of(context)
                  .accentColor,
              child: Text('add photo'),
              elevation: 8,
              onPressed: uploadImage,
              padding: EdgeInsets.all(15),
              shape: CircleBorder(),
            ),
            RawMaterialButton(
              fillColor: Theme
                  .of(context)
                  .accentColor,
              child: Text('clear image'),
              elevation: 8,
              onPressed: clearImage,
              padding: EdgeInsets.all(15),
              shape: CircleBorder(),
            ),
            RawMaterialButton(
              fillColor: Theme
                  .of(context)
                  .accentColor,
              child: Text('view photos'),
              elevation: 8,
              onPressed: viewImage,
              padding: EdgeInsets.all(15),
              shape: CircleBorder(),
            ),

            Container( child:image != null ? image : Text('nil'))
            ],
        )
    );
  }


}



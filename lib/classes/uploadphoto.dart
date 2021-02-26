

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class UploadPhoto extends StatefulWidget {
  UploadPhoto() : super();

  @override
  UploadPhotoState createState() => UploadPhotoState();

}

class UploadPhotoState extends State<UploadPhoto> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Image image;
  Future<void> uploadImage() async {
    FilePickerResult picked = await FilePicker.platform.pickFiles();
    if (picked != null) {
      Uint8List imgData = picked.files.single.bytes;
      setState(() {
        image = Image.memory(imgData);
      });
      Reference ref = _firebaseStorage.ref('uploads/testtext.txt');
      //await ref.putData(imgData);
      //need to add index.html to the thingo



    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            RawMaterialButton(
              fillColor: Theme
                  .of(context)
                  .accentColor,
              child: Icon(Icons.add_photo_alternate_rounded,
                color: Colors.white,),
              elevation: 8,
              onPressed: uploadImage,
              padding: EdgeInsets.all(15),
              shape: CircleBorder(),
            ),
            Container( child:image != null ? image : Text('nil'))
            ])
    );
  }


}



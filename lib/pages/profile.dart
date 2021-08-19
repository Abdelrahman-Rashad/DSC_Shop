import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shop/classes/cloudDatabase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:shop/classes/cloudStorage.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, required this.db, required this.name, required this.email})
      : super(key: key);

  CloudDatabase db;
  String name, email;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;

  FirebaseStorage storage = FirebaseStorage.instance;

  /*Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(source: ImageSource.gallery);
      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);
      try {
        await storage.ref((fileName).put(imageFile));
        setState(() {
          _image = imageFile;
        });
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    backgroundImage: _image == null ? null : FileImage(_image!),
                  ),
                ),
                Align(
                  alignment: Alignment(0.3, 0),
                  child: IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: () {},
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "name : ${widget.name}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter + Alignment(0, 0.3),
                    child: Text(
                      "Email : ${widget.email}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class CloudStorage {
  late UploadTask task;
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } catch (e) {
      return null;
    }
  }

  Future<String> uploadImage(File file) async {
    final fileName = p.basename(file.path);
    final destination = 'image/$fileName';
    task = CloudStorage.uploadFile(destination, file)!;

    final snapshot = await task.whenComplete(() => null);
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CloudDatabase {
  late FirebaseFirestore firestore;

  initialize() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String email) async {
    try {
      await firestore.collection('user').add({'name': name, 'email': email});
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List objects = [];

    try {
      querySnapshot = await firestore.collection('user').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map obj = {"id": doc.id, "name": doc['name'], "email": doc['email']};
          objects.add(obj);
        }
      }
      return objects;
    } catch (e) {
      print(e);
      return objects;
    }
  }

  Future<void> update(String id, String name, String email) async {
    try {
      await firestore
          .collection('user')
          .doc(id)
          .update({'name': name, 'email': email});
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection('user').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}

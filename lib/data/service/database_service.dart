
import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getAllItems() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection('items').get();
    var allItems = snapshot.docs.map((docSnapshot) => {docSnapshot.id: docSnapshot.data()}).toList();
    Map<String, dynamic> i = {};
    for (var element in allItems) {
      element.forEach((key, value) {
        i.addEntries([MapEntry(key, value)]);
      });
    }
    return i;
  }
}
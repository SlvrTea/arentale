
import 'package:arentale/data/service/database_service.dart';
import 'package:arentale/domain/game/player/equip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/game/stats.dart';
import '../player_db.dart';

class PlayerService extends DBService {

  Future<PlayerDB> getPlayer() async {
    final pref = await SharedPreferences.getInstance();
    final String uuid = pref.getString('uid')!;
    final snapshot = db.collection(uuid);
    final allItems = await DBService().getAllItems();
    final DocumentSnapshot<Map<String, dynamic>> stats = await snapshot.doc('stats').get();
    final DocumentSnapshot<Map<String, dynamic>> inventory = await snapshot.doc('inventory').get();
    final DocumentSnapshot<Map<String, dynamic>> equip = await snapshot.doc('equip').get();
    final DocumentSnapshot<Map<String, dynamic>> info = await snapshot.doc('info').get();
    final playerMap = {
      'stats': Stats.fromDocumentSnapshot(stats),
      'inventory': inventory.data(),
      'equip': Equip.fromJson(equip.data()!, allItems),
      'info': info.data(),
      'skills': stats.data()!['skills']
    };
    return PlayerDB.fromDB(playerMap);
  }

  void changeInfo({required String doc, required String field, required int value, String updateType = 'set'}) async {
    final pref = await SharedPreferences.getInstance();
    final uuid = pref.getString('uid')!;
    final playerCollection = db.collection(uuid);
    final DocumentSnapshot<Map<String, dynamic>> snapshot;
    int data;

    try {
      snapshot = await playerCollection.doc(doc).get();
      if (updateType == 'add') {
        data = snapshot.data()![field];
        data += value;
        return;
      }
      playerCollection.doc(doc).update({field: value});
    } catch(e) {
      rethrow;
    }
  }

  static createPlayer({
    required String uuid,
    required Map<String, dynamic> stats,
    required Map<String, dynamic> equip,
    required Map<String, dynamic> inventory,
    required Map<String, dynamic> info
  }) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection(uuid).doc('stats').set(stats);
    db.collection(uuid).doc('equip').set(equip);
    db.collection(uuid).doc('inventory').set(inventory);
    db.collection(uuid).doc('info').set(info);
  }
}
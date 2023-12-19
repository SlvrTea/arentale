
import 'package:cloud_firestore/cloud_firestore.dart';

import '../db/mob_db.dart';
import 'database_service.dart';

class MobService extends DBService {
  Future<MobDB> getMob(mobId) async {
    final snapshot = db.collection('mobs');
    final DocumentSnapshot<Map<String, dynamic>> mob = await snapshot.doc(mobId).get();
    return MobDB.fromDB(mob);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/game/stats.dart';

class MobDB {
  final Stats stats;
  final Map<String, dynamic> info;

  MobDB.fromDB(DocumentSnapshot<Map<String, dynamic>> map):
      stats = Stats.fromJson(map['stats']),
      info = map['info'];
}
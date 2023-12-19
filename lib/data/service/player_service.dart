
import 'package:arentale/data/service/database_service.dart';
import 'package:arentale/domain/game/equip/equip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/game/game_entities/stats.dart';
import '../db/player_db.dart';

enum DataUpdateType {
  set, add
}

class PlayerService extends DBService {
  final uuid = Hive.box('userInfo').get('uuid');
  final userInfo = Hive.box('userInfo');

  Future<PlayerDB> getPlayer() async {
    final snapshot = db.collection(uuid);
    final allItems = await DBService().getAllItems();
    final stats = await snapshot.doc('stats').get();
    final inventory = await snapshot.doc('inventory').get();
    final equip = await snapshot.doc('equip').get();
    final info = await snapshot.doc('info').get();
    final playerMap = {
      'stats': Stats.fromDocumentSnapshot(stats),
      'inventory': inventory.data(),
      'equip': Equip.fromJson(equip.data()!, allItems),
      'info': info.data(),
      'skills': stats.data()!['skills']
    };
    return PlayerDB.fromDB(playerMap);
  }

  void changeInfo({required String doc, required String field, required dynamic value, DataUpdateType updateType = DataUpdateType.set}) async {
    final playerCollection = db.collection(uuid);
    final DocumentSnapshot<Map<String, dynamic>> snapshot;
    int data;

    try {
      snapshot = await playerCollection.doc(doc).get();
      if ((updateType == DataUpdateType.add) && (value is int)) {
        data = snapshot.data()![field];
        data += value;
        playerCollection.doc(doc).update({field: data});
        return;
      }
      playerCollection.doc(doc).update({field: value});
    } catch(e) {
      throw Exception('Incorrect data try to check db path or given value\n$e');
    }
  }

  Future<void> changeLocation(String location) async {
    changeInfo(
        doc: 'info',
        field: 'location',
        value: location
    );
  }

  Future<void> changeClass(String newClass) async {
    final playerInfo = await db.collection(uuid).doc('info').get();
    final playerStats = await db.collection(uuid).doc('stats').get();
    const baseStats = {
      'Blade Master': {
        'baseHP': 60,
        'baseMP': 55,
        'baseSTR': 5,
        'baseINT': 1,
        'baseVIT': 3,
        'baseSPI': 2,
        'baseDEX': 9
      },
      'Berserk': {
        'baseHP': 65,
        'baseMP': 50,
        'baseSTR': 10,
        'baseINT': 1,
        'baseVIT': 5,
        'baseSPI': 2,
        'baseDEX': 2
      },
      'Guardian': {
        'baseHP': 70,
        'baseMP': 45,
        'baseSTR': 10,
        'baseINT': 1,
        'baseVIT': 5,
        'baseSPI': 2,
        'baseDEX': 2
      },
      'Poison Master': {
        'baseHP': 55,
        'baseMP': 60,
        'baseSTR': 5,
        'baseINT': 1,
        'baseVIT': 2,
        'baseSPI': 2,
        'baseDEX': 10
      },
      'Thug': {
        'baseHP': 65,
        'baseMP': 45,
        'baseSTR': 10,
        'baseINT': 1,
        'baseVIT': 3,
        'baseSPI': 1,
        'baseDEX': 5
      },
      'Shadow': {
        'baseHP': 55,
        'baseMP': 65,
        'baseSTR': 5,
        'baseINT': 1,
        'baseVIT': 2,
        'baseSPI': 2,
        'baseDEX': 10
      }
    };
    const levelStats = {
      'Blade Master': {
        'baseHP': 5,
        'baseMP': 5,
        'baseSTR': 3,
        'baseVIT': 2,
        'baseSPI': 1,
        'baseDEX': 5
      },
      'Berserk': {
        'baseHP': 5,
        'baseMP': 5,
        'baseSTR': 8,
        'baseVIT': 2,
        'baseDEX': 1
      },
      'Guardian': {
        'baseHP': 10,
        'baseMP': 5,
        'baseSTR': 3,
        'baseVIT': 7,
        'baseSPI': 1,
      },
      'Poison Master': {
        'baseHP': 5,
        'baseMP': 5,
        'baseSTR': 1,
        'baseVIT': 3,
        'baseDEX': 7
      },
      'Thug': {
        'baseHP': 8,
        'baseMP': 3,
        'baseSTR': 6,
        'baseVIT': 3,
        'baseDEX': 2
      },
      'Shadow': {
        'baseHP': 5,
        'baseMP': 5,
        'baseSTR': 2,
        'baseVIT': 2,
        'baseDEX': 7
      }
    };
    int getLevelStat(String key) {
      int result = 0;
      if (levelStats[playerInfo.data()!['class']]!.containsKey(key)) {
        result = (levelStats[playerInfo.data()!['class']]![key]! * (playerInfo.data()!['level'] - 1)).toInt();
      }
      return result;
    }
    for (var element in playerStats.data()!.keys) {
      playerStats.data()![element] = baseStats[playerInfo.data()!['class']]![element]! + getLevelStat(element);
    }
    playerStats.data()!['skills'] = [];
    playerInfo.data()!['class'] = newClass;
    db.collection(uuid).doc('stats').update(playerStats.data()!);
    db.collection(uuid).doc('info').update(playerInfo.data()!);
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
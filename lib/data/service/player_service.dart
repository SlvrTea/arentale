
import 'dart:math';

import 'package:arentale/data/service/database_service.dart';
import 'package:arentale/domain/game/player/equip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/game/stats.dart';
import '../player_db.dart';

class PlayerService extends DBService{

  Future<PlayerDB> getPlayer(String uuid) async {
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

  void addExperience(String uuid, int value) async {
    final playerCollection = db.collection(uuid);
    final DocumentSnapshot<Map<String, dynamic>> info = await playerCollection.doc('info').get();
    final Map<String, dynamic> newInfo = info.data()!;
    final lForm = (100 * pow(newInfo['level'], 0.8)).round();

    newInfo['exp'] += value;
    playerCollection.doc('info').update({'exp': newInfo['exp']}).then((_) {
      if(newInfo['exp'] >= lForm) {
        levelUp(uuid);
      }
    });
  }

  void levelUp(String uuid) async {
    final playerCollection = db.collection(uuid);
    final DocumentSnapshot<Map<String, dynamic>> info = await playerCollection.doc('info').get();
    final Map<String, dynamic> newInfo = info.data()!;
    final DocumentSnapshot<Map<String, dynamic>> stat = await playerCollection.doc('stats').get();
    final Map<String, dynamic> newStat = stat.data()!;
    final Map<String, Map<String, int>> levelStat = {
      'Rogue': {
        'baseHP': 5,
        'baseMP': 3,
        'baseSTR': 2,
        'baseINT': 0,
        'baseVIT': 1,
        'baseSPI': 1,
        'baseDEX': 3
      },
     'Warrior': {
       'baseHP': 8,
       'baseMP': 3,
       'baseSTR': 3,
       'baseINT': 0,
       'baseVIT': 2,
       'baseSPI': 1,
       'baseDEX': 1
     },
     'Mage': {
       'baseHP': 3,
       'baseMP': 10,
       'baseSTR': 0,
       'baseINT': 3,
       'baseVIT': 1,
       'baseSPI': 2,
       'baseDEX': 2
      }
    };
    final lForm = (100 * pow(newInfo['level'], 0.8)).round();

    newInfo['exp'] = newInfo['exp'] - lForm;
    newInfo['level'] += 1;

    levelStat[newInfo['class']]!.keys.forEach((element) {
      newStat[element] += levelStat[newInfo['class']]![element];
    });

    playerCollection.doc('info').update(newInfo);
    playerCollection.doc('stats').update(newStat);
  }

  void setExperience(String uuid, int value) async {
    final playerCollection = db.collection(uuid);
    final DocumentSnapshot<Map<String, dynamic>> info = await playerCollection.doc('info').get();
    int newInfo = info.data()!['exp'];

    newInfo = value;
    playerCollection.doc('info').update({'exp': newInfo});
  }

  void addGold(String uuid, int value) async {
    final playerCollection = db.collection(uuid);
    final DocumentSnapshot<Map<String, dynamic>> info = await playerCollection.doc('info').get();
    int newInfo = info.data()!['gold'];

    newInfo += value;
    playerCollection.doc('info').update({'gold': newInfo});
  }

  void addItem(String uuid, String item, {int amount = 1}) async {
    final playerCollection = db.collection(uuid);
    final DocumentSnapshot<Map<String, dynamic>> info = await playerCollection.doc('inventory').get();
    final Map<String, dynamic> newInfo = info.data()!;

    if (newInfo.containsKey(item)) {
      newInfo[item] += amount;
    } else {
      newInfo.addAll({item: 1});
    }
    playerCollection.doc('inventory').set(newInfo);
  }

  void changeInfo(String uuid, String key, {int value = 1}) async {
    final playerCollection = db.collection(uuid);
    final DocumentSnapshot<Map<String, dynamic>> info = await playerCollection.doc('info').get();
    final Map<String, dynamic> newInfo = info.data()!;

    newInfo[key] += value;
    playerCollection.doc('info').set(newInfo);
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
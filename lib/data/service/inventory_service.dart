
import 'package:arentale/data/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InventoryService extends DBService {
  final uuid = Hive.box('userInfo').get('uuid');
  Future<Map<String, dynamic>> getInventory() async {
    final snapshot = db.collection(uuid);
    final inventory = await snapshot.doc('inventory').get();
    return inventory.data()!;
  }

  @override
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

  void addItems(List<String> items) async {
    final inv = await getInventory();
    final snapshot = db.collection(uuid);
    final inventory = snapshot.doc('inventory');
    for (String element in items) {
      if (inv.containsKey(element)) {
        inv[element] += 1;
        continue;
      }
      inv.addAll({element: 1});
    }
    inventory.update(inv);
  }

  void removeItems(List<String> items) async {
    final inv = await getInventory();
    final snapshot = db.collection(uuid);
    final inventory = snapshot.doc('inventory');
    for(var element in items) {
      if (inv[element] == 1) {
        inv.remove(element);
        continue;
      }
      inv[element] -= 1;
    }
    inventory.set(inv);
  }

  void changeEquip(String slot, String newItem) async {
    final snapshot = db.collection(uuid);
    final equipDoc = snapshot.doc('equip');
    final equip = await equipDoc.get();
    final equipMap = equip.data()!;
    addItems([equipMap[slot]]);
    equipMap[slot] = newItem;
    removeItems([newItem]);
    equipDoc.set(equipMap);
  }
}
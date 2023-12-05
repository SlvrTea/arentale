
import 'package:arentale/domain/game/game_entities/stat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Stats {
  final Stat HP;
  final Stat MP;
  final Stat STR;
  final Stat INT;
  final Stat VIT;
  final Stat SPI;
  final Stat DEX;
  final Stat physicalDamageResist = Stat(1);
  final Stat physicalDamageModifier = Stat(1);
  final Stat magicalDamageResist = Stat(1);
  final Stat magicalDamageModifier = Stat(1);

  Stats.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> map):
    HP = Stat(map.data()!['baseHP']),
    MP = Stat(map.data()!['baseMP']),
    STR = Stat(map.data()!['baseSTR']),
    INT = Stat(map.data()!['baseINT']),
    VIT = Stat(map.data()!['baseVIT']),
    SPI = Stat(map.data()!['baseSPI']),
    DEX = Stat(map.data()!['baseDEX']);

  Stats.fromJson(Map<String, dynamic> map):
    HP = Stat(map['baseHP']),
    MP = Stat(map['baseMP']),
    STR = Stat(map['baseSTR']),
    INT = Stat(map['baseINT']),
    VIT = Stat(map['baseVIT']),
    SPI = Stat(map['baseSPI']),
    DEX = Stat(map['baseDEX']);
}
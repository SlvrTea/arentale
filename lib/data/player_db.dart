
import '../domain/game/player/equip.dart';
import '../domain/game/stats.dart';

class PlayerDB {
  final Stats stats;
  final Map<String, dynamic> inventory;
  final Equip equip;
  final Map<String, dynamic> info;
  final List skills;

  PlayerDB.fromDB(Map<String, dynamic> map):
    stats = map['stats'],
    inventory = map['inventory'],
    info = map['info'],
    equip = map['equip'],
    skills = map['skills'];
}
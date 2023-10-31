
import 'package:arentale/domain/game/stats.dart';
import 'player/equip.dart';

abstract class GameObject {
  final Stats stats;
  final Map<String, dynamic> inventory;
  final Equip equip;
  final Map<String, dynamic> info;

  GameObject({
    required this.stats,
    required this.inventory,
    required this.equip,
    required this.info
    });

  get HP => stats.HP.finalValue;
  get maxHP => stats.HP.baseValue;
  get MP => stats.MP.finalValue;
  get maxMP => stats.MP.baseValue;

  void takeDamage({required int value});

  void consumeMP({required int value});

  Map<String, dynamic> cast({required String name});
}
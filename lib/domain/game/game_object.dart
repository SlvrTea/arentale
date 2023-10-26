
import 'package:arentale/domain/game/stats.dart';
import 'player/equip.dart';

abstract class GameObject {
  final Stats stats;
  final Map<String, dynamic> inventory;
  final Equip equip;

  GameObject({
    required this.stats,
    required this.inventory,
    required this.equip
    });

  void takeDamage({required int value});

  void consumeMP({required int value});

  Map<String, dynamic> cast(String name);
}
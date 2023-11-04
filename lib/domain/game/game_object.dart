
import 'package:arentale/domain/game/stats.dart';

abstract class GameObject {
  final Stats stats;
  final Map<String, dynamic> info;
  final List effects = [];

  GameObject({
    required this.stats,
    required this.info
    });

  int get HP => stats.HP.finalValue;
  int get maxHP => stats.HP.baseValue;
  int get MP => stats.MP.finalValue;
  int get maxMP => stats.MP.baseValue;
  int get ATK => getATK();
  int get MATK => getMATK();

  get STR => stats.STR.finalValue;
  get INT => stats.INT.finalValue;
  get VIT => stats.VIT.finalValue;
  get SPI => stats.SPI.finalValue;
  get DEX => stats.DEX.finalValue;

  void takeDamage(int value);

  void consumeMP(int value);

  int getATK();

  int getMATK();

  int crit() {
    return 1;
  }

  int evade() {
    return 1;
  }

  String cast() {
    return '';
  }
}
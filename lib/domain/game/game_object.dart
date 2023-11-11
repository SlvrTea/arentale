
import 'dart:math';

import 'package:arentale/domain/game/effect.dart';
import 'package:arentale/domain/game/stats.dart';

abstract class GameObject {
  final Stats stats;
  final Map<String, dynamic> info;
  final List<Effect> effects = [];

  GameObject({
    required this.stats,
    required this.info
    });

  int get HP => stats.HP.finalValue;
  int get maxHP => stats.HP.baseValue;
  int get MP => stats.MP.finalValue;
  int get baseMP => stats.MP.baseValue;
  int get maxMP => stats.MP.baseValue;
  int get ATK => getATK();
  int get MATK => getMATK();

  get STR => stats.STR.finalValue;
  get INT => stats.INT.finalValue;
  get VIT => stats.VIT.finalValue;
  get SPI => stats.SPI.finalValue;
  get DEX => stats.DEX.finalValue;

  // Stat _critDamage = Stat((1 + pow(DEX, DEX/1000))).finalValue;
  // double get critDamage => ;

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

  String effectTicks() {
    String result = '';
    for (Effect e in effects) {
      result += e.tick().ef();
      if (e.duration == 0) {
        effects.remove(e);
      }
    }
    return result;
  }

  List getDrop() {
    return [];
  }

  void applyEffect(Effect effect) {
    bool apply = true;
    effects.forEach((element) {
      if (element.name == effect.name) {
        apply = false;
        if (element.stack + 1 <= element.maxStack) {
          element.stack += 1;
          return;
        } else {
          return;
        }
      }
    });
    if (apply) {
      effects.add(effect);
    }
  }
}

import 'dart:math';

import 'package:arentale/domain/game/effect.dart';
import 'package:arentale/domain/game/stats.dart';

import 'stat.dart';

abstract class GameObject {
  final Stats stats;
  final Map<String, dynamic> info;
  final List<Effect> effects = [];
  late Stat _critDamage;
  late Stat _critChance;
  late Stat _evasionChance;

  GameObject({
    required this.stats,
    required this.info
    }) {
    _critDamage = Stat((1 + ((pow(DEX, DEX/1000) * 100).round() / 100)));
    _critChance = Stat(((pow(DEX, 0.05) - 1) * 100).round() / 100);
    _evasionChance = Stat(((pow(DEX, DEX/1000) * 100).round() / 100));
  }

  int get HP => stats.HP.finalValue.round();
  int get maxHP => stats.HP.baseValue.round();
  int get MP => stats.MP.finalValue.round();
  int get baseMP => stats.MP.baseValue.round();
  int get maxMP => stats.MP.baseValue.round();
  int get ATK => getATK();
  int get MATK => getMATK();

  int get STR => stats.STR.finalValue.round();
  int get INT => stats.INT.finalValue.round();
  int get VIT => stats.VIT.finalValue.round();
  int get SPI => stats.SPI.finalValue.round();
  int get DEX => stats.DEX.finalValue.round();

  Stat get critDamage => _critDamage;
  Stat get critChance => _critChance;
  Stat get evasionChance => _evasionChance;

  num get physicalResist => stats.physicalDamageResist.finalValue;
  num get physicalModifier => stats.physicalDamageModifier.finalValue;
  num get magicalResist => stats.magicalDamageResist.finalValue;
  num get magicalModifier => stats.magicalDamageModifier.finalValue;

  void takeDamage(int value);

  void consumeMP(int value);

  int getATK();

  int getMATK();

  bool isCrit() {
    if (Random().nextDouble() < critChance.finalValue) {
      return true;
    }
    return false;
  }

  bool isEvade() {
    return false;
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

  List<String> getDrop() {
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
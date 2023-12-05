
import 'dart:math';

import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/game_entities/effect.dart';
import 'package:arentale/domain/game/game_entities/stats.dart';

import 'stat.dart';

abstract class IStats {
  final Stats stats;

  const IStats(this.stats);

  int get HP;
  int get maxHP;
  int get MP;
  int get baseMP;
  int get maxMP;
  int get ATK;
  int get MATK;

  int get STR;
  int get INT;
  int get VIT;
  int get SPI;
  int get DEX;

  num get physicalResist;
  num get physicalModifier;
  num get magicalResist;
  num get magicalModifier;
}

abstract mixin class Crits {
  Stat get critChance;
  Stat get critDamage;

  bool isCrit() {
    if (Random().nextDouble() < critChance.finalValue) {
      return true;
    }
    return false;
  }
}

abstract mixin class Evade {
  Stat get evasionChance;

  bool isEvade() {
    if (Random().nextDouble() < evasionChance.finalValue) {
      return true;
    }
    return false;
  }
}

abstract class ICast {
  String cast();
}

abstract mixin class EffectManager {
  final List<Effect> effects = [];

  List effectTicks() {
    List<BattleEvent> result = [];
    List<Effect> toRemove = [];
    for (Effect e in effects) {
      result.add(e.tick());
      if (e.duration == 0) {
        toRemove.add(e);
      }
    }
    effects.removeWhere((element) => toRemove.contains(element));
    return result;
  }

  void applyEffect(Effect effect) {
    bool apply = true;
    for (Effect element in effects) {
      if (element.name == effect.name) {
        apply = false;
        if (element.stack + 1 <= element.maxStack) {
          element.stack += 1;
          continue;
        }
        continue;
      }
    }
    if (apply) {
      effects.add(effect);
    }
  }
}

abstract class Drop {
  List<String> getDrop() {
    return [];
  }
}

abstract class GameObject with Crits, EffectManager, Evade implements IStats, ICast {
  final Map<String, dynamic> info;

  GameObject({
    required this.info
    });

  void takeDamage(int value);

  void consumeMP(int value);

  int getATK();

  int getMATK();
}

class BlankGameObject implements GameObject {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

import 'dart:math';

import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/game/stat.dart';
import 'package:arentale/domain/game/stat_modifier.dart';

class Mob extends GameObject {
  late Stat _statHP;
  late Stat _statMP;

  Mob({
    required super.stats,
    required super.info,
  }) {
    _statHP = Stat(stats.HP.finalValue + (stats.VIT.finalValue * 5));
    _statMP = Stat(stats.MP.finalValue + (stats.SPI.finalValue * 3));
  }

  @override
  int get HP => _statHP.finalValue.round();
  @override
  int get maxHP => _statHP.baseValue.round();

  @override
  int get MP => _statMP.finalValue.round();
  @override
  get maxMP => _statMP.baseValue.round();

  @override
  void consumeMP(int value) {
    _statMP.addModifier(StatModifier(-value));
  }

  @override
  void takeDamage(int value) {
    _statHP.addModifier(StatModifier(-value));
  }

  @override
  int getATK() {
    return stats.STR.finalValue.round();
  }

  @override
  int getMATK() {
    return stats.INT.finalValue.round();
  }

  @override
  String cast() {
    final List mobSkills = info['skills'];
    final String randSkill = mobSkills[Random().nextInt(mobSkills.length)];
    return randSkill;
  }

  @override
  List<String> getDrop() {
    final List<String> drop = [];
    for (var e in info['drop'].keys) {
      final rand = Random().nextDouble();
      if (rand >= info['drop'][e]) {
        drop.add(e);
      }
    }
    return drop;
  }
}
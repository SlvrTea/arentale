
// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:arentale/domain/game/game_entities/game_object.dart';
import 'package:arentale/domain/game/game_entities/stat.dart';
import 'package:arentale/domain/game/game_entities/stat_modifier.dart';
import 'package:arentale/domain/game/game_entities/stats.dart';

class Mob extends GameObject implements Drop {
  late Stat _statHP;
  late Stat _statMP;
  late Stat _critDamage;
  late Stat _critChance;
  late Stat _evasionChance;

  @override
  final Stats stats;

  Mob({
    required this.stats,
    required super.info,
  }) {
    _statHP = Stat(stats.HP.finalValue + (stats.VIT.finalValue * 5));
    _statMP = Stat(stats.MP.finalValue + (stats.SPI.finalValue * 3));
    _critDamage = Stat((0.5 + ((pow(DEX, DEX/1000) * 100).round() / 100)));
    _critChance = Stat(((pow(DEX, 0.05) - 1) * 100).round() / 100);
    _evasionChance = Stat(((pow(DEX, DEX/1000) * 100).round() / 100) - 1);
  }

  @override
  int get HP => _statHP.finalValue.round();
  @override
  int get baseMP => stats.MP.baseValue.round();
  @override
  int get maxHP => _statHP.baseValue.round();
  @override
  int get MP => _statMP.finalValue.round();

  @override
  get maxMP => _statMP.baseValue.round();
  @override
  int get ATK => getATK();
  @override
  int get MATK => getMATK();
  @override
  int get STR => stats.STR.finalValue.round();
  @override
  int get INT => stats.INT.finalValue.round();
  @override
  int get VIT => stats.VIT.finalValue.round();
  @override
  int get SPI => stats.SPI.finalValue.round();
  @override
  int get DEX => stats.DEX.finalValue.round();

  @override
  Stat get critChance => _critChance;
  @override
  Stat get critDamage => _critDamage;
  @override
  Stat get evasionChance => _evasionChance;
  @override
  num get magicalModifier => stats.magicalDamageModifier.finalValue;
  @override
  num get magicalResist => stats.magicalDamageResist.finalValue;
  @override
  num get physicalModifier => stats.physicalDamageModifier.finalValue;
  @override
  num get physicalResist => stats.physicalDamageResist.finalValue;

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
      if (rand <= info['drop'][e]) {
        drop.add(e);
      }
    }
    return drop;
  }
}
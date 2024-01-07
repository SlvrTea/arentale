
// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:arentale/domain/game/game_entities/game_object.dart';
import 'package:arentale/domain/game/game_entities/stat_modifier.dart';
import 'package:arentale/domain/game/game_entities/stats.dart';

import '../game_entities/stat.dart';
import '../equip/equip.dart';

class Player extends GameObject {
  final List skills;
  final Map<String, dynamic> inventory;
  final Equip equip;
  late Stat _statHP;
  late Stat _statMP;
  late Stat _critDamage;
  late Stat _critChance;
  late Stat _evasionChance;

  @override
  final Stats stats;

  Player({
    required this.stats,
    required super.info,
    required this.inventory,
    required this.equip,
    required this.skills,
  }) {
    _statHP = Stat(stats.HP.finalValue + (equip.getStat('VIT') + stats.VIT.finalValue) * 5);
    _statMP = Stat(stats.MP.finalValue + (equip.getStat('SPI') + stats.SPI.finalValue) * 3);
    _critDamage = Stat((0.5 + ((pow(DEX, DEX/1000) * 100).round() / 100)));
    _critChance = Stat(((pow(DEX, 0.05) - 1) * 100).round() / 100);
    _evasionChance = Stat(((pow(DEX, DEX/900) * 100).round() / 100) - 1);
  }

  @override
  int get HP => _statHP.finalValue.round();
  @override
  int get maxHP => _statHP.baseValue.round();
  @override
  int get MP => _statMP.finalValue.round();
  @override
  int get baseMP => stats.MP.finalValue.round();
  @override
  get maxMP => _statMP.baseValue.round();

  @override
  get ATK => getATK();
  @override
  get MATK => getMATK();
  @override
  get STR => (stats.STR.finalValue + (equip.getStat('STR'))).round();
  @override
  get INT => (stats.INT.finalValue + (equip.getStat('INT'))).round();
  @override
  get VIT => (stats.VIT.finalValue + (equip.getStat('VIT'))).round();
  @override
  get SPI => (stats.SPI.finalValue + (equip.getStat('SPI'))).round();
  @override
  get DEX => (stats.DEX.finalValue + (equip.getStat('DEX'))).round();

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

  get lForm => (100 * pow(info['level'], 1.2)).round();

  @override
  void consumeMP(int value) {
    _statMP.addModifier(StatModifier(-value));
    if (_statMP.finalValue >= maxMP) {
      _statMP.modifiers.clear();
    }
  }

  @override
  void takeDamage(int value) {
    _statHP.addModifier(StatModifier(-value));
    if (_statHP.finalValue - value >= maxHP) {
      _statHP.modifiers.clear();
    }
  }

  @override
  int getATK() {
    num ATK = 0;
    switch(info['class']) {
      case 'Warrior':
        ATK = equip.getStat('ATK') + (equip.getStat('STR') + stats.STR.finalValue) * 3;
      case 'Mage':
        ATK = equip.getStat('ATK') + (equip.getStat('STR') + stats.STR.finalValue);
      case 'Rogue':
        ATK = equip.getStat('ATK') + (equip.getStat('STR') + stats.STR.finalValue) % 2 + (equip.getStat('DEX') + stats.DEX.finalValue) * 2;
      case 'Poison Master':
        ATK = equip.getStat('ATK') + (equip.getStat('STR') + stats.STR.finalValue) * 2 + (equip.getStat('DEX') + stats.DEX.finalValue);
    }
    return ATK.round();
  }

  @override
  int getMATK() {
    num MATK = 0;
    switch(info['class']) {
      case 'Warrior':
        MATK = equip.getStat('MATK') + (equip.getStat('INT') + stats.INT.finalValue) % 3;
      case 'Mage':
        MATK = equip.getStat('MATK') + (equip.getStat('INT') + stats.INT.finalValue) * 3;
      case 'Rogue':
        MATK = equip.getStat('MATK') + (equip.getStat('INT') + stats.INT.finalValue) % 2;
      case 'Poison Master':
        MATK = equip.getStat('MATK') + (equip.getStat('INT') + stats.INT.finalValue) % 2;
    }
    return MATK.round();
  }
}
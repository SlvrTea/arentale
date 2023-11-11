
import 'dart:math';

import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/game/stat_modifier.dart';

import '../stat.dart';
import 'equip.dart';

class Player extends GameObject {
  final List skills;
  final Map<String, dynamic> inventory;
  final Equip equip;
  late Stat _statHP;
  late Stat _statMP;

  Player({
    required super.stats,
    required super.info,
    required this.inventory,
    required this.equip,
    required this.skills
  }) {
    _statHP = Stat(stats.HP.finalValue + (equip.getStat('VIT') + stats.VIT.finalValue) * 5);
    _statMP = Stat(stats.MP.finalValue + (equip.getStat('SPI') + stats.SPI.finalValue) * 3);
  }

  @override
  int get HP => _statHP.finalValue;
  @override
  int get maxHP => _statHP.baseValue;

  @override
  int get MP => _statMP.finalValue;
  int get baseMP => stats.MP.finalValue;
  @override
  get maxMP => _statMP.baseValue;

  @override
  get ATK => getATK();
  @override
  get MATK => getMATK();
  get STR => stats.STR.finalValue + (equip.getStat('STR'));
  get INT => stats.INT.finalValue + (equip.getStat('INT'));
  get VIT => stats.VIT.finalValue + (equip.getStat('VIT'));
  get SPI => stats.SPI.finalValue + (equip.getStat('SPI'));
  get DEX => stats.DEX.finalValue + (equip.getStat('DEX'));
  // Stat get critChance => Stat(pow(DEX, 0.05) - 1);
  // Stat get critDamage => Stat(1 + pow(DEX, DEX/1000));

  get lForm => (100 * pow(info['level'], 0.8)).round();

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
    int ATK = 0;
    switch(info['class']) {
      case 'Warrior':
        ATK = equip.getStat('ATK') + (equip.getStat('STR') + stats.STR.finalValue) * 3;
      case 'Mage':
        ATK = equip.getStat('ATK') + (equip.getStat('STR') + stats.STR.finalValue);
      case 'Rogue':
        ATK = equip.getStat('ATK') + (equip.getStat('STR') + stats.STR.finalValue) % 2 + (equip.getStat('DEX') + stats.DEX.finalValue) * 2;
    }
    return ATK;
  }

  @override
  int getMATK() {
    int MATK =0;
    switch(info['class']) {
      case 'Warrior':
        MATK = equip.getStat('MATK') + (equip.getStat('INT') + stats.INT.finalValue) % 3;
      case 'Mage':
        MATK = equip.getStat('MATK') + (equip.getStat('INT') + stats.INT.finalValue) * 3;
      case 'Rogue':
        MATK = equip.getStat('MATK') + (equip.getStat('INT') + stats.INT.finalValue) % 2;
    }
    return MATK;
  }

  void addExp(int value) async {

  }
}
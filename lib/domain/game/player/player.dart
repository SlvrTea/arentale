
import 'dart:math';

import 'package:arentale/domain/game/game_object.dart';

import '../stat.dart';

class Player extends GameObject {
  final Map<String, dynamic> info;
  Player({required super.stats,
    required super.inventory,
    required super.equip,
    required this.info});

  get HP => stats.HP.finalValue + (equip.getStat('VIT') + stats.VIT.finalValue) * 5;
  get maxHP => stats.HP.finalValue + (equip.getStat('VIT') + stats.VIT.finalValue) * 5;
  get MP => stats.MP.finalValue + (equip.getStat('SPI') + stats.SPI.finalValue) * 3;
  get maxMP => stats.MP.finalValue + (equip.getStat('SPI') + stats.SPI.finalValue) * 3;
  get ATK => getATK();
  get MATK => getMATK();
  get STR => stats.STR.finalValue + (equip.getStat('STR'));
  get INT => stats.INT.finalValue + (equip.getStat('INT'));
  get VIT => stats.VIT.finalValue + (equip.getStat('VIT'));
  get SPI => stats.SPI.finalValue + (equip.getStat('SPI'));
  get DEX => stats.DEX.finalValue + (equip.getStat('DEX'));
  // Stat get critChance => Stat(pow(DEX, 0.05) - 1);
  // Stat get critDamage => Stat(1 + pow(DEX, DEX/1000));

  @override
  void consumeMP({required int value}) {
    // TODO: implement consumeMP
  }

  @override
  void takeDamage({required int value}) {
    // TODO: implement takeDamage
  }

  num getATK() {
    num ATK = 0;
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

  num getMATK() {
    num MATK =0;
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
}
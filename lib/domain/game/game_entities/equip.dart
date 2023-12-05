
import '../game_entities/equip_item.dart';

class Equip {
  EquipItem rHand;
  EquipItem lHand;
  EquipItem armor;
  EquipItem trinket;

  int getStat(String stat) {
    int statSum = 0;
    switch(stat) {
      case 'STR':
        statSum = rHand.equipSTR + lHand.equipSTR + armor.equipSTR + trinket.equipSTR;
      case 'INT':
        statSum = rHand.equipINT + lHand.equipINT + armor.equipINT + trinket.equipINT;
      case 'VIT':
        statSum = rHand.equipVIT + lHand.equipVIT + armor.equipVIT + trinket.equipVIT;
      case 'SPI':
        statSum = rHand.equipSPI + lHand.equipSPI + armor.equipSPI + trinket.equipSPI;
      case 'DEX':
        statSum = rHand.equipDEX + lHand.equipDEX + armor.equipDEX + trinket.equipDEX;
      case 'ATK':
        statSum  = rHand.equipATK + lHand.equipATK + armor.equipATK + trinket.equipATK;
      case 'MATK':
        statSum  = rHand.equipMATK + lHand.equipMATK + armor.equipMATK + trinket.equipMATK;
    }
    return statSum;
  }

  Equip.fromJson(Map<String, dynamic>json, allItems):
        rHand = EquipItem.fromJson(allItems, json['rHand']),
        lHand = EquipItem.fromJson(allItems, json['lHand']),
        armor = EquipItem.fromJson(allItems, json['armor']),
        trinket = EquipItem.fromJson(allItems, json['trinket']);
}
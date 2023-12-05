import 'package:arentale/data/service/player_service.dart';

void createWarrior(String uuid, String name) {
  Map<String, dynamic> newPlayerInfo = {
    'id': uuid,
    'level': 1,
    'exp': 0,
    'gold': 0,
    'class': 'Warrior',
    'name': name,
    'wins': 1,
    'battles': 1,
    'quest complete': 0,
    'weapon types': [
      '1h sword',
      '2h sword',
      '1h axe',
      '2h axe',
      'dagger',
      '1h blunt',
      '2h blunt',
      'shield'
    ],
    'armor types': [
      'cloth',
      'leather',
      'mail',
      'plate'
    ]
  };
  Map<String, dynamic> newPlayerStats = {
    'baseHP': 60,
    'baseMP': 55,
    'baseSTR': 5,
    'baseINT': 1,
    'baseVIT': 3,
    'baseSPI': 1,
    'baseDEX': 2,
    'skills': ['Swing And Cut']
  };
  Map<String, dynamic> newPlayerEquip = {
    'rHand': 'Old Sword',
    'lHand': 'None',
    'armor': 'Tarnished Braided Bib',
    'trinket': 'None'
  };
  Map<String, dynamic> newPlayerInventory = {};

  PlayerService.createPlayer(
      uuid: uuid,
      stats: newPlayerStats,
      equip: newPlayerEquip,
      inventory: newPlayerInventory,
      info: newPlayerInfo
  );
}

void createRogue(String uuid, String name) {
  Map<String, dynamic> newPlayerInfo = {
    'id': uuid,
    'level': 1,
    'exp': 0,
    'gold': 0,
    'class': 'Rogue',
    'name': name,
    'wins': 1,
    'battles': 1,
    'quest complete': 0,
    'weapon types': [
      'dagger',
      '1h sword',
      '1h axe',
      '1h blunt'
    ],
    'armor types': [
      'cloth',
      'leather'
    ]
  };
  Map<String, dynamic> newPlayerStats = {
    'baseHP': 40,
    'baseMP': 65,
    'baseSTR': 2,
    'baseINT': 2,
    'baseVIT': 1,
    'baseSPI': 2,
    'baseDEX': 5,
    "skills": ['Sneaky blow', 'Evasion']
  };
  Map<String, dynamic> newPlayerEquip = {
    'rHand': 'Sharp Dagger',
    'lHand': 'Sharp Dagger',
    'armor': 'Leather Cape Of Rascal',
    'trinket': 'None'
  };
  Map<String, dynamic> newPlayerInventory = {};

  PlayerService.createPlayer(
      uuid: uuid,
      stats: newPlayerStats,
      equip: newPlayerEquip,
      inventory: newPlayerInventory,
      info: newPlayerInfo
  );
}

void createMage(String uuid, String name) {
  Map<String, dynamic> newPlayerInfo = {
    'id': uuid,
    'level': 1,
    'exp': 0,
    'gold': 0,
    'class': 'Mage',
    'name': name,
    'wins': 1,
    'battles': 1,
    'quest complete': 0,
    'weapon types': [
      '1h staff',
      '2h staff'
    ],
    'armor types': [
      'cloth'
    ]
  };
  Map<String, dynamic> newPlayerStats = {
    'baseHP': 35,
    'baseMP': 75,
    'baseSTR': 1,
    'baseINT': 5,
    'baseVIT': 1,
    'baseSPI': 4,
    'baseDEX': 2,
    'skills': ['Fireball']
  };
  Map<String, dynamic> newPlayerEquip = {
    'rHand': 'Apprentices Staff',
    'lHand': 'None',
    'armor': 'Novices Attire',
    'trinket': 'None'
  };
  Map<String, dynamic> newPlayerInventory = {};

  PlayerService.createPlayer(
      uuid: uuid,
      stats: newPlayerStats,
      equip: newPlayerEquip,
      inventory: newPlayerInventory,
      info: newPlayerInfo
  );
}
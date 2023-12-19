
import 'package:arentale/data/service/player_service.dart';
import 'package:arentale/domain/repository/player_repository.dart';
import 'package:arentale/internal/dependencies/repository_module.dart';

import 'game/player/player.dart';

class PlayerModel {
  bool _needToUpdate = false;
  Player player;
  final PlayerRepository playerRepository = RepositoryModule.playerRepository();

  PlayerModel({
    required this.player
  });

  void markAsNeededToUpdate() async {
    _needToUpdate = true;
    player = await playerRepository.getPlayer();
    _needToUpdate = false;
  }

  void changeLocation(String location) {
    player.info['location'] = location;
    playerRepository.changeLocation(location);
  }

  void addGold(int value) {
    player.info['gold'] += value;
    playerRepository.updateInfo(doc: 'info', field: 'gold', value: player.info['gold']);
  }

  void addExp(int value) {
    player.info['exp'] += value;
    if (player.info['exp'] >= player.lForm) {
      levelUp();
      return;
    }
    playerRepository.updateInfo(doc: 'info', field: 'exp', value: player.info['exp']);
  }

  void addItems(List<String> items) {
    for (String element in items) {
      if (player.inventory.containsKey(element)) {
        player.inventory[element] += 1;
        continue;
      }
      player.inventory.addAll({element: 1});
      playerRepository.updateInfo(
          doc: 'inventory',
          field: element,
          value: player.inventory[element]
      );
    }
  }

  void levelUp() {
    final Map<String, Map<String, int>> levelStat = {
      'Rogue': {
        'baseHP': 5,
        'baseMP': 3,
        'baseSTR': 2,
        'baseINT': 0,
        'baseVIT': 1,
        'baseSPI': 1,
        'baseDEX': 3
      },
      'Warrior': {
        'baseHP': 8,
        'baseMP': 3,
        'baseSTR': 3,
        'baseINT': 0,
        'baseVIT': 2,
        'baseSPI': 1,
        'baseDEX': 1
      },
      'Mage': {
        'baseHP': 3,
        'baseMP': 10,
        'baseSTR': 0,
        'baseINT': 3,
        'baseVIT': 1,
        'baseSPI': 2,
        'baseDEX': 2
      }
    };
    final levelSkills = {
      'Warrior': {
        2: 'Swift Rush',
        3: 'Bloodletting'
      },
      'Rogue': {
        2: 'Evasion',
        3: 'Experimental Potion'
      }
    };
    final levelPassive = {
      'Blade Master': {
        7: 'Bonecrusher'
      }
    };

    player.info['exp'] -= player.lForm;
    player.info['level'] += 1;
    playerRepository.updateInfo(doc: 'info', field: 'exp', value: player.info['exp']);
    playerRepository.updateInfo(doc: 'info', field: 'level', value: player.info['level']);

    for (var element in levelStat[player.info['class']]!.keys) {
      playerRepository.updateInfo(
          doc: 'stats',
          field: element,
          value: levelStat[player.info['class']]![element],
          updateType: DataUpdateType.add
      );
    }
    if (levelSkills[player.info['class']]!.containsKey(player.info['level'])) {
      player.skills.add(levelSkills[player.info['class']]![player.info['level']]);
      playerRepository.updateInfo(
          doc: 'stats',
          field: 'skills',
          value: player.skills
      );
    }
  }
}
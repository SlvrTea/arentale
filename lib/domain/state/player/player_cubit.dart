import 'package:arentale/domain/game/player/player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/service/player_service.dart';
import '../../../internal/dependencies/repository_module.dart';
import '../../repository/player_repository.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final PlayerRepository playerRepository = RepositoryModule.playerRepository();
  PlayerCubit() : super(PlayerLoadingState());

  void loadPlayer() async {
    final player = await playerRepository.getPlayer();
    emit(PlayerLoadedState(player: player));
  }

  void addGold(int value) {
    state.player.info['gold'] += value;
    playerRepository.updateInfo(doc: 'info', field: 'gold', value: state.player.info['gold']);
    loadPlayer();
  }

  void levelUp() {
    final player = state.player;
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
    loadPlayer();
  }

  void addExp(int value) {
    state.player.info['exp'] += value;
    if (state.player.info['exp'] >= state.player.lForm) {
      levelUp();
      return;
    }
    playerRepository.updateInfo(doc: 'info', field: 'exp', value: state.player.info['exp']);
    loadPlayer();
  }

  void addItems(List<String> items) {
    for (String element in items) {
      if (state.player.inventory.containsKey(element)) {
        state.player.inventory[element] += 1;
        continue;
      }
      state.player.inventory.addAll({element: 1});
      playerRepository.updateInfo(
          doc: 'inventory',
          field: element,
          value: state.player.inventory[element]
      );
    }
    loadPlayer();
  }

  void changeClass(String newClass) {
    playerRepository.changeClass(newClass);
    loadPlayer();
  }
}

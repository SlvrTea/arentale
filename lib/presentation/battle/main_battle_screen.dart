
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/game/game_entities/game_object.dart';
import '../../domain/game/player/player.dart';
import '../../domain/state/battle/battle_bloc.dart';
import 'battle_button.dart';
import 'battle_log.dart';
import 'battle_tiles.dart';

class BattleMain extends StatelessWidget {
  const BattleMain({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BattleBloc>().state;
    if (state is BattleLoadedState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EnemyTile(char: state.mob),
          BattleLog(state.battleController.log),
          PlayerTile(char: state.player),
          _getSkillButtons(state.player, state.mob)
        ],
      );
    }
    return const Placeholder();
  }

  Widget _getSkillButtons(Player player, GameObject mob) {
    return Card(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: player.skills.map((e) => BattleButton(skillName: e)).toList()
      ),
    );
  }
}


import 'package:arentale/domain/state/battle/battle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/game/skill.dart';

class BattleButton extends StatelessWidget {
  final String skillName;
  const BattleButton({super.key, required this.skillName});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<BattleBloc>();
    final state = bloc.state;
    if (state is BattleLoadedState) {
      return IconButton(
        onPressed: () {
          state.battleController.turn(skillName);
          bloc.add(BattleLogUpdateEvent(state));
          if (state.player.HP <= 0 || state.mob.HP <= 0) {
            bloc.add(BattleEndEvent(state.battleController.log));
          }
        },
        icon: Image.asset(getSkill(state.player, state.mob, skillName)!.iconPath!),
        tooltip: getSkill(state.player, state.mob, skillName)!.tooltip,
      );
    }
    return const Center();
  }
}
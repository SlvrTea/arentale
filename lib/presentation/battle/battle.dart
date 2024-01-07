
import 'dart:math';

import 'package:arentale/domain/state/battle/battle_bloc.dart';
import 'package:arentale/presentation/battle/battle_end_screen.dart';
import 'package:arentale/presentation/battle/main_battle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/state/player/player_cubit.dart';

class Battle extends StatelessWidget {
  final List<String> mobs;
  const Battle({super.key, required this.mobs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BattleBloc(),
        child: BlocBuilder<BattleBloc, BattleState>(
          builder: (context, state) {
            if (state is BattleLoadedState) {
              return const BattleMain();
            }
            else if (state is BattleLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is BattleEndState) {
              return BattleEnd(log: state.log);
            }
            final cubit = context.watch<PlayerCubit>();
            if (cubit.state is PlayerLoadedState) {
              var mob = mobs[Random().nextInt(mobs.length)];
              BlocProvider.of<BattleBloc>(context).add(BattleLoadingEvent(mob, cubit));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/state/player/player_cubit.dart';
import '../home.dart';
import 'battle_log.dart';

class BattleEnd extends StatelessWidget {
  final String log;
  const BattleEnd({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PlayerCubit>();
    if (cubit.state is! PlayerLoadedState) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BattleLog(log),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const Home())
              );
            },
            child: const Text('Ok')
        )
      ],
    );
  }
}

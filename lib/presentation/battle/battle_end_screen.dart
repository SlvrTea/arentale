
import 'package:arentale/domain/player_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import 'battle_log.dart';

class BattleEnd extends StatelessWidget {
  final String log;
  const BattleEnd({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final playerModel = context.watch<PlayerModel?>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BattleLog(log),
        ElevatedButton(
            onPressed: () {
              playerModel!.markAsNeededToUpdate();
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

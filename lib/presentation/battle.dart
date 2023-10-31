
import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/state/player/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Battle extends StatelessWidget {
  const Battle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PlayerBloc(),
        child: BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            BlocProvider.of<PlayerBloc>(context).add(PlayerStartBattleEvent());
            if (state is PlayerBattle) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getEnemyTile(state.mob),
                  _getBattleLog(
                      state.battleController.log,
                      MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width
                  ),
                  _getPlayerTile(state.player)
                ],
              );
            }
            return const Center(
                child: CircularProgressIndicator()
            );
          },
        ),
      ),
    );
  }

  Widget _getHealthBar(GameObject char) {
    return LinearProgressIndicator(
      value: (char.HP / char.maxHP),
      minHeight: 7,
      color: Colors.green,
    );
  }

  Widget _getManaBar(GameObject char) {
    return LinearProgressIndicator(
      value: (char.MP / char.maxMP),
      minHeight: 7,
      color: Colors.blue,
    );
  }

  Widget _getEnemyTile(GameObject enemy) {
    return Card(
      child: ListTile(
        title: const Text('TEST ENEMY'),
        leading: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7)
            ),
            SizedBox(
              width: 200,
              child: _getHealthBar(enemy),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7)
            ),
            SizedBox(
              width: 200,
              child: _getManaBar(enemy),
            ),
          ],
        ),
        trailing: const CircleAvatar(
          child: Icon(Icons.account_circle_outlined),
        )
      ),
    );
  }

  Widget _getPlayerTile(GameObject player) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.account_circle_outlined),
        ),
        title: Text(player.info['name']),
        trailing: Column(
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7)
            ),
            SizedBox(
              width: 200,
              child: _getHealthBar(player),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7)
            ),
            SizedBox(
              width: 200,
              child: _getManaBar(player),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _getBattleLog(String log, double height, double width) {
    return SizedBox(
      height: height * 0.75,
      width: width,
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(log, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
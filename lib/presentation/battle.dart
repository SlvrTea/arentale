
import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/state/battle/battle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/game/player/player.dart';
import '../domain/player_model.dart';
import 'battle_button.dart';
import 'home.dart';

class Battle extends StatelessWidget {
  const Battle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BattleBloc(),
        child: BlocBuilder<BattleBloc, BattleState>(
          builder: (context, state) {
            if (state is BattleLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getEnemyTile(state.mob),
                  _getBattleLog(
                      state.battleController.log,
                      MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width
                  ),
                  _getPlayerTile(state.player),
                  _getSkillButtons(state.player, state.mob)
                ],
              );
            }
            else if (state is BattleLoadingState) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            }
            else if (state is BattleEndState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getBattleLog(state.log, MediaQuery.of(context).size.height * 0.9, MediaQuery.of(context).size.width),
                  ElevatedButton(
                      onPressed: () async {
                        final pref = await SharedPreferences.getInstance();
                        if (pref.getString('uid') == null) {
                          return;
                        }
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => Wrapper(uuid: pref.getString('uid')!))
                        );
                      },
                      child: const Text('Ok')
                  )
                ],
              );
            }
            else {
              final playerModel = context.watch<PlayerModel?>();
              if (playerModel != null) {
                BlocProvider.of<BattleBloc>(context).add(BattleLoadingEvent('boar', playerModel));
              }
              return const Center();
            }
          },
        ),
      ),
    );
  }

  Widget _getSkillButtons(Player player, GameObject mob) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: player.skills.map((e) => BattleButton(skillName: e)).toList()
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
      semanticsLabel: '100',
    );
  }

  Widget _getEnemyTile(GameObject enemy) {
    return Card(
      child: ListTile(
        title:  Text(enemy.info['name']),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 200,
              child: _getHealthBar(enemy),
            ),
            SizedBox(
              width: 200,
              child: _getManaBar(enemy),
            ),
            SizedBox(
              width: 200,
              child: Row(
                children: enemy.effects.map((e) => Image.asset(e.iconPath)).toList()
              ),
            )
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 200,
              child: _getHealthBar(player),
            ),
            SizedBox(
              width: 200,
              child: _getManaBar(player),
            ),
            SizedBox(
              width: 200,
              child: Row(
                  children: player.effects.map((e) => Image.asset(e.iconPath)).toList()
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _getBattleLog(String log, double height, double width) {
    return SizedBox(
      height: height * 0.65,
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
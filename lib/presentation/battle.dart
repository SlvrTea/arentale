
import 'dart:math';

import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/state/battle/battle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arentale/domain/game/skill.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: state.player.skills.map((e) => IconButton(
                      onPressed: () {
                        state.player.effects.forEach((element) {
                          state.battleController.loop.events.add(element.tick());
                        });
                        getSkill(state.player, state.mob, e)!.cast().forEach((element) {
                          state.battleController.loop.events.add(element);
                        });
                        state.mob.effects.forEach((element) {
                          state.battleController.loop.events.add(element.tick());
                        });
                        getSkill(state.mob, state.player, state.mob.cast())!.cast().forEach((element) {
                          state.battleController.loop.events.add(element);
                        });
                        state.battleController.turn();
                        BlocProvider.of<BattleBloc>(context).add(BattleLogUpdateEvent(state));
                        state.player.effects.forEach((element) {print(element.duration);});
                        if (state.mob.HP <= 0) {
                          final drop = state.mob.getDrop();
                          final int exp = (state.mob.info['exp'] + Random().nextInt((state.mob.info['exp'] / 2).round()));
                          final int gold = (state.mob.info['gold'] + Random().nextInt((state.mob.info['exp'] / 2).round()));
                          BlocProvider.of<BattleBloc>(context).add(BattleEndEvent(
                                drop,
                                exp,
                                gold,
                                '${state.battleController.log}\nПолучено: $drop\nПолучено:$exp опыта\nПолучено:$gold золота'
                            )
                          );
                        } else if (state.player.HP <= 0) {
                          BlocProvider.of<BattleBloc>(context).add(BattleEndEvent(
                              const [],
                              0,
                              0,
                              '${state.battleController.log}\nВы проиграли!'
                            )
                          );
                        }
                      },
                      icon: Image.asset(getSkill(state.player, state.mob, e)!.iconPath!),
                      tooltip: getSkill(state.player, state.mob, e)!.tooltip,
                      )
                    ).toList()
                  ),
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
              BlocProvider.of<BattleBloc>(context).add(BattleLoadingEvent('boar'));
              return const Center();
            }
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
      semanticsLabel: '100',
    );
  }

  Widget _getEnemyTile(GameObject enemy) {
    return Card(
      child: ListTile(
        title:  Text(enemy.info['name']),
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

import 'package:arentale/domain/game/player/stat_element.dart';
import 'package:arentale/domain/state/player/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../generated/l10n.dart';

class CharInfo extends StatelessWidget {
  const CharInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerBloc>(
      create: (context) => PlayerBloc(),
      child: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if(state is PlayerLoading) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else if(state is PlayerLoaded){
            return ListView(
              children: [
                Card(
                  child: ExpansionTile(
                    title: Text(state.player.info['name']),
                    subtitle: Text(state.player.info['class']),
                    leading: const CircleAvatar(child: Icon(Icons.account_circle_outlined)),
                    initiallyExpanded: true,
                    children: [
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircularPercentIndicator(
                              radius: 40,
                              header: const Text('Win Rate'),
                              progressColor: Colors.red,
                              percent: (state.player.info['wins'] / state.player.info['battles']),
                              center: Text('${((state.player.info['wins'] / state.player.info['battles']) * 100).round()}%'),
                            ),
                            CircularPercentIndicator(
                                radius: 40,
                                header: Text(S.of(context).experience),
                                progressColor: Colors.blue,
                                percent: (state.player.info['exp'] / state.player.lForm),
                                center: Text('${((state.player.info['exp'] / state.player.lForm) * 100).round()}%'),
                            )
                          ],
                        )
                      ),
                      StatElement(
                        statName: S.of(context).health,
                        statValue: state.player.HP.toString(),
                      ),
                      StatElement(
                        statName: S.of(context).mana,
                        statValue: state.player.MP.toString(),
                      ),
                      StatElement(
                        statName: S.of(context).attack,
                        statValue: state.player.ATK.toString(),
                      ),
                      StatElement(
                        statName: S.of(context).spellPower,
                        statValue: state.player.MATK.toString(),
                      ),
                      StatElement(
                        statName: S.of(context).strength,
                        statValue: state.player.STR.toString(),
                      ),
                      StatElement(
                        statName: S.of(context).intelligence,
                        statValue: state.player.INT.toString(),
                      ),
                      StatElement(
                        statName: S.of(context).vitality,
                        statValue: state.player.VIT.toString(),
                      ),
                      StatElement(
                        statName: S.of(context).spirit,
                        statValue: state.player.SPI.toString(),
                      ),
                      StatElement(
                        statName: S.of(context).dexterity,
                        statValue: state.player.DEX.toString(),
                      ),
                      StatElement(
                          statName: S.of(context).critChance, 
                          statValue: state.player.critChance.finalValue.toString()
                      ),
                      StatElement(
                          statName: S.of(context).critDamage,
                          statValue: state.player.critDamage.finalValue.toString()
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            BlocProvider.of<PlayerBloc>(context).add(PlayerGetPlayerEvent());
            return const Center();
          }
        },
      ),
    );
  }
}
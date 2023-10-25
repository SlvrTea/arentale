
import 'package:arentale/domain/game/player/stat_element.dart';
import 'package:arentale/domain/state/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
                    children: [
                      Card(
                        child: CircularPercentIndicator(
                          radius: 30,
                          header: const Text('Win Rate'),
                          progressColor: Colors.red,
                          percent: (state.player.info['wins'] / state.player.info['battles']),
                          center: Text('${((state.player.info['wins'] / state.player.info['battles']) * 100).round()}%'),
                        )
                      ),
                      StatElement(
                        statName: 'Health',
                        statValue: state.player.HP.toString(),
                      ),
                      StatElement(
                        statName: 'Mana',
                        statValue: state.player.MP.toString(),
                      ),
                      StatElement(
                        statName: 'Attack',
                        statValue: state.player.ATK.toString(),
                      ),
                      StatElement(
                        statName: 'Spell Power',
                        statValue: state.player.MATK.toString(),
                      ),
                      StatElement(
                        statName: 'Strength',
                        statValue: state.player.STR.toString(),
                      ),
                      StatElement(
                        statName: 'Intelligence',
                        statValue: state.player.INT.toString(),
                      ),
                      StatElement(
                        statName: 'Vitality',
                        statValue: state.player.VIT.toString(),
                      ),
                      StatElement(
                        statName: 'Spirit',
                        statValue: state.player.SPI.toString(),
                      ),
                      StatElement(
                        statName: 'Dexterity',
                        statValue: state.player.DEX.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            BlocProvider.of<PlayerBloc>(context).add(PlayerGetPlayerEvent());
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
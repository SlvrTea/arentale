
import 'package:arentale/domain/game/player/player.dart';
import 'package:arentale/domain/game/player/stat_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../domain/player_model.dart';
import '../generated/l10n.dart';

class CharInfo extends StatelessWidget {
  const CharInfo({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerModel? playerModel = context.watch<PlayerModel?>();
    if (playerModel == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    Player player = playerModel.player;
    return ListView(
      children: [
        Card(
          child: ExpansionTile(
            title: Text(player.info['name']),
            subtitle: Text(player.info['class']),
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
                        percent: (player.info['wins'] / player.info['battles']),
                        center: Text('${((player.info['wins'] / player.info['battles']) * 100).round()}%'),
                      ),
                      CircularPercentIndicator(
                        radius: 40,
                        header: Text(S.of(context).experience),
                        progressColor: Colors.blue,
                        percent: (player.info['exp'] / player.lForm),
                        center: Text('${((player.info['exp'] / player.lForm) * 100).round()}%'),
                      )
                    ],
                  )
              ),
              StatElement(
                statName: S.of(context).health,
                statValue: player.HP.toString(),
              ),
              StatElement(
                statName: S.of(context).mana,
                statValue: player.MP.toString(),
              ),
              StatElement(
                statName: S.of(context).attack,
                statValue: player.ATK.toString(),
              ),
              StatElement(
                statName: S.of(context).spellPower,
                statValue: player.MATK.toString(),
              ),
              StatElement(
                statName: S.of(context).strength,
                statValue: player.STR.toString(),
              ),
              StatElement(
                statName: S.of(context).intelligence,
                statValue: player.INT.toString(),
              ),
              StatElement(
                statName: S.of(context).vitality,
                statValue: player.VIT.toString(),
              ),
              StatElement(
                statName: S.of(context).spirit,
                statValue: player.SPI.toString(),
              ),
              StatElement(
                statName: S.of(context).dexterity,
                statValue: player.DEX.toString(),
              ),
              StatElement(
                  statName: S.of(context).critChance,
                  statValue: '${(player.critChance.finalValue * 100).round()}%'
              ),
              StatElement(
                  statName: S.of(context).critDamage,
                  statValue: '${(player.critDamage.finalValue * 100).round()}%'
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:arentale/domain/game/player/player.dart';
import 'package:arentale/presentation/stat_element.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          _PlayerTitleWidget(player: player),
          _PlayerInfoWidget(player: player),
          _PlayerStatsWidget(player: player),
        ],
      ),
    );
  }
}

class _PlayerTitleWidget extends StatelessWidget {
  final Player player;
  const _PlayerTitleWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(child: Icon(Icons.account_circle_outlined))
          ),
        ),
        Text(
          player.info['name'],
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500
          ),
        ),
        Text(player.info['class']),
        const Divider(),
      ],
    );
  }
}

class _PlayerInfoWidget extends StatelessWidget {
  final Player player;
  const _PlayerInfoWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(S.of(context).infoTitle),
      leading: const Icon(Icons.area_chart),
      children: [
        Row(
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
        ),
        ListTile(
          title: Text('${S.of(context).level}: ${player.info['level']}'),
        ),
        ListTile(
          title: Text('${S.of(context).gold }: ${player.info['gold']}'),
        ),
      ],
    );
  }
}

class _PlayerStatsWidget extends StatelessWidget {
  final Player player;
  const _PlayerStatsWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(S.of(context).statsTitle),
      leading: const Icon(Icons.bar_chart),
      children: [
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
    );
  }
}


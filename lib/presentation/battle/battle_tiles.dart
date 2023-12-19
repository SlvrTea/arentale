
import 'package:arentale/domain/game/game_entities/game_object.dart';
import 'package:flutter/material.dart';
import 'package:info_popup/info_popup.dart';

import 'battle_bars.dart';

class PlayerTile extends StatelessWidget {
  final GameObject char;
  const PlayerTile({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.account_circle_outlined),
        ),
        title: Text(char.info['name']),
        trailing: _TileContent(char: char),
      ),
    );
  }
}

class EnemyTile extends StatelessWidget {
  final GameObject char;
  const EnemyTile({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _TileContent(char: char),
        title: Text(char.info['name']),
      ),
    );
  }
}

class _TileContent extends StatelessWidget {
  final GameObject char;
  const _TileContent({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 200,
          child: HealthBar(char: char),
        ),
        SizedBox(
          width: 200,
          child: ManaBar(char: char),
        ),
        SizedBox(
          width: 200,
          child: Row(
              children: char.effects.map((e) => InfoPopupWidget(
                contentTitle: '${e.name}(${e.duration})\n${e.tooltip}',
                child: Image.asset(
                  e.iconPath,
                  cacheHeight: 30,
                ),
              )
              ).toList()
          ),
        )
      ],
    );
  }
}

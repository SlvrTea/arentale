

import 'package:arentale/domain/game/player/equip_item.dart';
import 'package:arentale/domain/player_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game/player/player.dart';

class Equipment extends StatelessWidget {
  const Equipment({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerModel? playerModel = context.watch<PlayerModel?>();
    Player? player = playerModel?.player;
    if (playerModel == null) {
      return const Center(child: CircularProgressIndicator());
    }

    List<EquipItem> items = [player!.equip.rHand, player.equip.lHand, player.equip.armor, player.equip.trinket];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
            title: Text(items[index].equipName)
        );
      },
    );
  }
}

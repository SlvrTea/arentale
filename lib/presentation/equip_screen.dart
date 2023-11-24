
import 'package:arentale/domain/game/player/equip_item.dart';
import 'package:arentale/domain/player_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game/player/player.dart';

class EquipScreen extends StatelessWidget {
  const EquipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerModel? playerModel = context.watch<PlayerModel?>();
    if (playerModel == null) {
      return const Center(child: CircularProgressIndicator());
    }
    Player player = playerModel.player;
    List<EquipItem> equipList = [player.equip.rHand, player.equip.lHand, player.equip.armor, player.equip.trinket];
    return ListView.builder(
      itemCount: equipList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ExpansionTile(
            title: Text(equipList[index].equipName),
          ),
        );
      }
    );
  }
}

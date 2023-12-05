
import 'package:arentale/domain/player_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game/game_entities/equip_item.dart';
import '../domain/game/player/player.dart';
import '../generated/l10n.dart';
import 'stat_element.dart';

class EquipScreen extends StatelessWidget {
  const EquipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerModel? playerModel = context.watch<PlayerModel?>();
    if (playerModel == null) {
      return const Center(child: CircularProgressIndicator());
    }
    Player player = playerModel.player;
    List<EquipItem> items = [player.equip.rHand, player.equip.lHand, player.equip.armor, player.equip.trinket];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equip'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return _EquipWidget(item: items[index]);
        },
      ),
    );
  }
}

class _EquipWidget extends StatelessWidget {
  final EquipItem item;
  const _EquipWidget({super.key, required this.item});

  Widget? _getIcon() {
    final Map<String, Widget> icons = {
      '': Image.asset(''),
      'none': Image.asset('assets/blank_icon.png'),
      'cloth': Image.asset('assets/cloth_armor.png'),
      'leather': Image.asset('assets/leather_armor.png'),
      'mail': Image.asset('assets/mail_armor.png'),
      'plate': Image.asset('assets/plate_armor.png'),
      'dagger': Image.asset('assets/dagger.png'),
      '1h sword': Image.asset('assets/one_handed_sword.png'),
      '1h axe': Image.asset('assets/one_handed_axe.png'),
      '1h blunt': Image.asset('assets/one_handed_blunt.png'),
    };
    return icons[item.equipType];
  }

  List<StatElement> _getStats(List<String> statNames) {
    final List stats = [item.slots.join(', '), item.equipType, item.equipATK.toString(), item.equipMATK.toString(), item.equipSTR.toString(), item.equipINT.toString(), item.equipVIT.toString(), item.equipSPI.toString(), item.equipDEX.toString()];
    if (item.equipType == 'none') {
      return [];
    }
    List<StatElement> result = [];
    stats.asMap().forEach((index, value) {
      result.add(StatElement(
          statName: statNames[index], 
          statValue: stats[index],
      ));
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: _getIcon(),
      title: Text(item.equipName),
      children: _getStats([S.of(context).slots, S.of(context).type, S.of(context).attack, S.of(context).spellPower, S.of(context).strength, S.of(context).intelligence, S.of(context).vitality, S.of(context).spirit, S.of(context).dexterity])
    );
  }
}
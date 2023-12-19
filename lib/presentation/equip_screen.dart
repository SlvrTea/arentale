
import 'package:arentale/data/service/database_service.dart';
import 'package:arentale/domain/player_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game/equip/equip_item.dart';
import '../domain/game/player/player.dart';
import '../generated/l10n.dart';
import 'char_info/stat_element.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _EquipWidget(item: items[0]),
              _EquipWidget(item: items[1]),
              _EquipWidget(item: items[2]),
              _EquipWidget(item: items[3]),
            ],
          ),
        ],
      )
    );
  }
}

class _EquipWidget extends StatelessWidget {
  final EquipItem item;
  const _EquipWidget({super.key, required this.item});

  Widget? _getIcon() {
    final Map<String, Widget> icons = {
      '': Image.asset(''),
      'none': Image.asset('assets/blank_icon.png', cacheHeight: 80),
      'cloth': Image.asset('assets/cloth_armor.png', cacheHeight: 80),
      'leather': Image.asset('assets/leather_armor.png', cacheHeight: 80),
      'mail': Image.asset('assets/mail_armor.png', cacheHeight: 80),
      'plate': Image.asset('assets/plate_armor.png', cacheHeight: 80),
      'dagger': Image.asset('assets/dagger.png', cacheHeight: 80),
      '1h sword': Image.asset('assets/one_handed_sword.png', cacheHeight: 80),
      '1h axe': Image.asset('assets/one_handed_axe.png', cacheHeight: 80),
      '1h blunt': Image.asset('assets/one_handed_blunt.png', cacheHeight: 80),
    };
    return icons[item.equipType];
  }

  List<Widget> _getStats(List<String> statNames) {
    final List stats = [item.slots.join(', '), item.equipType, item.equipATK.toString(), item.equipMATK.toString(), item.equipSTR.toString(), item.equipINT.toString(), item.equipVIT.toString(), item.equipSPI.toString(), item.equipDEX.toString()];
    if (item.equipType == 'none') {
      return [];
    }
    List<Widget> result = [];
    stats.asMap().forEach((index, value) {
      result.add(Flexible(
        child: StatElement(
          statName: statNames[index],
          statValue: stats[index],
        ),
      ));
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(item.equipName),
              content: Column(
                  children:_getStats([S.of(context).slots, S.of(context).type, S.of(context).attack, S.of(context).spellPower, S.of(context).strength, S.of(context).intelligence, S.of(context).vitality, S.of(context).spirit, S.of(context).dexterity])
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Назад'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      // showDialog(context: context, builder: (BuildContext cont) {
                      //   return _EquipChange(inventory: pla, slot: item.slots);
                      // });
                    },
                    child: const Text('Сменить')
                )
              ],
            );
          },
        );
      },
      icon: _getIcon() ?? Image.asset('assets/blank_icon.png')
    );
  }
}

class _EquipChange extends StatelessWidget {
  final Map<String, Map> inventory;
  final List slot;
  const _EquipChange({super.key, required this.inventory, required this.slot});

  Future<List> _getValidItems() async {
    final allItems = await DBService().getAllItems();
    final result = [];
    for (var key in inventory.keys) {
      if(allItems[key].containsKey('slot') && allItems[key]['slot'].contains(slot)) {
        result.add(EquipItem.fromJson(allItems[key], key));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      scrollable: true,
      title: Text('Инвентарь'),
    );
  }
}

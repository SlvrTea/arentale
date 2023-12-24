
import 'package:arentale/domain/const.dart';
import 'package:arentale/domain/player_model.dart';
import 'package:arentale/domain/state/equip/equip_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game/equip/equip_item.dart';
import '../domain/game/player/player.dart';
import '../generated/l10n.dart';
import 'char_info/stat_element.dart';

Widget? _getIcon(EquipItem item) {
  const size = 60;
  final Map<String, Widget> icons = {
    '': Image.asset(''),
    'none': Image.asset('assets/blank_icon.png', cacheHeight: size),
    'cloth': Image.asset('assets/cloth_armor.png', cacheHeight: size),
    'leather': Image.asset('assets/leather_armor.png', cacheHeight: size),
    'mail': Image.asset('assets/mail_armor.png', cacheHeight: size),
    'plate': Image.asset('assets/plate_armor.png', cacheHeight: size),
    'dagger': Image.asset('assets/dagger.png', cacheHeight: size),
    '1h sword': Image.asset('assets/one_handed_sword.png', cacheHeight: size),
    '1h axe': Image.asset('assets/one_handed_axe.png', cacheHeight: size),
    '1h blunt': Image.asset('assets/one_handed_blunt.png', cacheHeight: size),
  };
  return icons[item.equipType];
}

class EquipScreen extends StatelessWidget {
  const EquipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerModel? playerModel = context.watch<PlayerModel?>();
    if (playerModel == null) {
      return const Center(child: CircularProgressIndicator());
    }
    Player player = playerModel.player;
    List<_EquipWidget> items = [
      _EquipWidget(item: player.equip.rHand, equipSlot: 'rHand'),
      _EquipWidget(item: player.equip.lHand, equipSlot: 'lHand'),
      _EquipWidget(item: player.equip.armor, equipSlot: 'armor'),
      _EquipWidget(item: player.equip.trinket, equipSlot: 'trinket')
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Экипировка'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //Image.asset('assets/person.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  items[0],
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 34)),
                  items[1],
                ],
              ),
              Column(
                children: [
                  items[2],
                  const Padding(padding: EdgeInsets.symmetric(vertical: 34)),
                  items[3],
                ]
              )
            ],
          ),
          Expanded(
            child: Card(
              child: items.any((element) => element.isActive) ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(player.info['name'], style: const TextStyle(fontSize:24, fontWeight: FontWeight.w600)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Здоровье: ${player.stats.HP.finalValue} + ${player.equip.getStat('HP')}', style: const TextStyle(fontSize:18)),
                      Text('Мана: ${player.stats.MP.finalValue} + ${player.equip.getStat('MP')}', style: const TextStyle(fontSize:18))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Сила: ${player.stats.STR.finalValue} + ${player.equip.getStat('STR')}', style: const TextStyle(fontSize:18)),
                      Text('Интеллект: ${player.stats.INT.finalValue} + ${player.equip.getStat('INT')}', style: const TextStyle(fontSize:18))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Выносливость: ${player.stats.VIT.finalValue} + ${player.equip.getStat('VIT')}', style: const TextStyle(fontSize:18)),
                      Text('Дух: ${player.stats.SPI.finalValue} + ${player.equip.getStat('SPI')}', style: const TextStyle(fontSize:18))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Ловкость: ${player.stats.DEX.finalValue} + ${player.equip.getStat('DEX')}', style: const TextStyle(fontSize:18)),
                    ],
                  ),
                ],
              ) :
              Placeholder()
            ),
          )
        ],
      )
    );
  }
}

class _EquipWidget extends StatelessWidget {
  final String equipSlot;
  final EquipItem item;
  _EquipWidget({super.key, required this.item, required this.equipSlot});

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        isActive = !isActive;
      },
      icon: _getIcon(item) ?? Image.asset('assets/blank_icon.png', cacheHeight: 80)
    );
  }
}

class _EquipChangeDialog extends StatelessWidget {
  final EquipItem item;
  final String slot;
  const _EquipChangeDialog({super.key, required this.item, required this.slot});

  List<Widget> _getStats(List<String> statNames) {
    final List stats = [item.slots.join(', '), item.equipType,
      item.equipATK.toString(), item.equipMATK.toString(),
      item.equipSTR.toString(), item.equipINT.toString(),
      item.equipVIT.toString(), item.equipSPI.toString(),
      item.equipDEX.toString()];
    if (item.equipType == 'none') {
      return [];
    }
    List<Widget> result = [];
    stats.asMap().forEach((index, value) {
      result.add(
        Flexible(
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
    return AlertDialog(
      title: Text(item.equipName),
      content: Column(
          children: _getStats([S.of(context).slots, S.of(context).type,
            S.of(context).attack, S.of(context).spellPower,
            S.of(context).strength, S.of(context).intelligence,
            S.of(context).vitality, S.of(context).spirit, S.of(context).dexterity])
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Назад'),
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
        ElevatedButton(
            onPressed: () {
              navigatorKey.currentState!.pop();
              navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => _EquipChange(slot: slot)));
            },
            child: const Text('Сменить')
        )
      ],
    );
  }
}

class _EquipChange extends StatelessWidget {
  final String slot;
  const _EquipChange({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
    final equipBloc = context.watch<EquipBloc>();
    final state = equipBloc.state;
    if (state is EquipValidState) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(children: state.validEquip),
        )
      );
    }
    equipBloc.add(EquipGetValidEvent(slot));
    return const Center(child: CircularProgressIndicator());
  }
}

class EquipTile extends StatelessWidget {
  final void Function() onTap;
  final EquipItem item;
  const EquipTile(this.item, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final playerModel = context.watch<PlayerModel?>();
    return ListTile(
      leading: _getIcon(item),
      title: Text(item.equipName),
      onTap: () {
        onTap();
        playerModel!.markAsNeededToUpdate();
      }
    );
  }
}


import 'package:arentale/domain/const.dart';
import 'package:arentale/domain/state/dialog/dialog_cubit.dart';
import 'package:flutter/material.dart';
import '../battle/battle.dart';
import '../game_dialog/dialog.dart';

enum DialogTags {
  startBattle,
  addTag
}

enum PlayerTags {
  warrior,
  rogue,
  mage,
  easternFederationCitizen,
  mercenary,
  nomad,
  traveller
}

abstract class GameLocation extends GameDialog {
  Map<int, Widget> locationMap = {};
  List<String> locationMobs = [];

  GameLocation({super.key, required super.dialogTree});

  void startBattle() {
    navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (_) => Battle(mobs: locationMobs))
    );
  }

  void setDialogCallbacks() {
    final Map<DialogTags, void Function()> callback = {
      DialogTags.startBattle: startBattle,
    };
    for (String dialogId in dialogTree.keys) {
      for (var e in dialogTree[dialogId]['options'].values) {
        if (e.containsKey('tags')) {
          for (var tag in e['tags']) {
            e.addAll({'onSelect': []});
            e['onSelect'].add(callback[tag]);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setDialogCallbacks();
    return super.build(context);
  }
}

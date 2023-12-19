import 'package:arentale/domain/const.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

abstract class GameLocation extends StatelessWidget {
  String initDialog;
  final userInfo = Hive.box('userInfo');
  Map<int, Widget> locationMap = {};
  Map dialogTree = {};
  late List<String> locationMobs;
  late GameDialog dialog;

  GameLocation({super.key, required this.initDialog}) {
    dialog = GameDialog(
      dialogTree: dialogTree,
      initDialog: initDialog,
    );
  }

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
    return GameDialog(
      dialogTree: dialogTree,
      initDialog: initDialog,
    );
  }
}

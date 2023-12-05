
import 'package:flutter/material.dart';
import '../battle.dart';
import '../dialog.dart';

enum DialogTags {
  startBattle
}

abstract class GameLocation extends StatelessWidget {
  final String initDialog;
  late Map<int, Widget> locationMap;
  late Map dialogTree;
  late List<String> locationMobs;
  GameLocation({super.key, required this.initDialog});

  @override
  Widget build(BuildContext context) {
    void startBattle() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => Battle(mobs: locationMobs))
      );
    }

    void setDialogCallbacks() {
      final Map<DialogTags, void Function()> callback = {
        DialogTags.startBattle: startBattle
      };
      for (String dialogId in dialogTree.keys) {
        for(var e in dialogTree[dialogId]['options'].values) {
          if (e.containsKey('tags')) {
            for (var tag in e['tags']) {
              e.addAll({'onSelect': []});
              e['onSelect'].add(callback[tag]);
            }
          }
        }
      }
    }
    setDialogCallbacks();
    return GameDialog(
      dialogTree: dialogTree,
      initDialog: initDialog,
    );
  }
}

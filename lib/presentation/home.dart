import 'package:arentale/domain/const.dart';
import 'package:arentale/presentation/char_info/char_info.dart';
import 'package:arentale/presentation/equip_screen.dart';
import 'package:arentale/presentation/inventory/inventory.dart';
import 'package:arentale/presentation/locations/location.dart';
import 'package:arentale/presentation/locations/slinsk.dart';
import 'package:arentale/presentation/game_map/map.dart';
import 'package:arentale/presentation/skill_tree.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../generated/l10n.dart';

GameLocation getLocation() {
  final userInfo = Hive.box('userInfo');
  final userLoc = userInfo.get('location');
  final locations = {
    'slinskPrologue': Slinsk(),
    'slinskTavern': Slinsk()
  };
  return locations[userLoc]!;
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = getLocation();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(S.of(context).appbar),
        actions: const [
          _MapButton()
        ],
      ),
      body: loc,
      drawer: const _Drawer(),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          navigatorKey.currentState!.push(
              MaterialPageRoute(
                  builder: (_) => MapScreen(map: getLocation().locationMap)
              )
          );
        },
        icon: const Icon(Icons.map)
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      navigatorKey.currentState!.push(
                          MaterialPageRoute(builder: (_) => const CharInfo())
                      );
                    },
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                  ),
                  ListTile(
                    onTap: () {
                      navigatorKey.currentState!.push(
                          MaterialPageRoute(builder: (_) => const EquipScreen())
                      );
                    },
                    leading: const Icon(Icons.shopping_bag),
                    title: const Text('Equip'),
                  ),
                  ListTile(
                    onTap: () {
                      navigatorKey.currentState!.push(
                          MaterialPageRoute(builder: (_) => const SkillTree())
                      );
                    },
                    leading: const Icon(Icons.book),
                    title: const Text('Skill tree'),
                  ),
                  ListTile(
                    onTap: () {
                      navigatorKey.currentState!.push(
                          MaterialPageRoute(builder: (_) => const Inventory())
                      );
                    },
                    leading: const Icon(Icons.backpack_rounded),
                    title: const Text('Инвентарь'),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}

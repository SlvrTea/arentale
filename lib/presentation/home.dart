import 'package:arentale/presentation/char_info.dart';
import 'package:arentale/presentation/equip_screen.dart';
import 'package:arentale/presentation/locations/slinsk.dart';
import 'package:arentale/presentation/map.dart';
import 'package:arentale/presentation/skill_tree.dart';
import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).appbar)),
      body: Slinsk(initDialog: 'd1.1'),
      drawer: const _Drawer(),
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CharInfo())
                      );
                    },
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const EquipScreen())
                      );
                    },
                    leading: const Icon(Icons.shopping_bag),
                    title: const Text('Equip'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const MapScreen(map: {}))
                      );
                    },
                    leading: const Icon(Icons.map),
                    title: const Text('Map'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SkillTree())
                      );
                    },
                    leading: const Icon(Icons.book),
                    title: const Text('Skill tree'),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}

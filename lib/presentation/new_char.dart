
import 'package:arentale/domain/game/player/create_new_char.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class NewChar extends StatelessWidget {
  const NewChar({super.key, required this.uuid, required this.name});
  final String uuid;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  createWarrior(uuid, name);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const Home())
                  );
                },
                child: const Text('Warrior')
            ),
            ElevatedButton(
                onPressed: () {
                  createRogue(uuid, name);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const Home())
                  );
                },
                child: const Text('Rogue')
            ),
            ElevatedButton(
                onPressed: () {
                  createMage(uuid, name);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const Home())
                  );
                },
                child: const Text('Mage')
            )
          ],
        ),
      ),
    );
  }
}
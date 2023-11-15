
import 'package:arentale/domain/game/player/create_new_char.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  createWarrior(uuid, name);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Wrapper(uuid: pref.getString('uid')!))
                  );
                },
                child: const Text('Warrior')
            ),
            ElevatedButton(
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  createRogue(uuid, name);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Wrapper(uuid: pref.getString('uid')!))
                  );
                },
                child: const Text('Rogue')
            ),
            ElevatedButton(
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  createMage(uuid, name);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Wrapper(uuid: pref.getString('uid')!))
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
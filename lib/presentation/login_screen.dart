
import 'package:arentale/presentation/home.dart';
import 'package:arentale/presentation/new_char.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final pref = await SharedPreferences.getInstance();
              if (pref.getString('uid') == null) {
                final uid = const Uuid().v1();
                pref.setString('uid', uid);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => NewChar(uuid: uid, name: 'Alpha Tester'))
                );
              } else {
                return;
              }
            },
            child: const Text('New Game'),
          ),
          ElevatedButton(
            onPressed: () async {
              final pref = await SharedPreferences.getInstance();
              if (pref.getString('uid') == null) {
                return;
              }
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => Wrapper(uuid: pref.getString('uid')!))
              );
            },
            child: const Text('Continue'),
          )
        ],
      );
  }
}
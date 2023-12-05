
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
            final uid = const Uuid().v1();

            Widget okButton = TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => NewChar(uuid: pref.getString('uid')!, name: 'Alpha Tester'))
                );
              },
            );

            Widget backButton = ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('back')
            );

            AlertDialog alert = AlertDialog(
              title: const Text("My title"),
              content: const Text("This is my message."),
              actions: [
                okButton,
                backButton
              ],
            );
            if (pref.getString('uid') == null) {
              pref.setString('uid', uid);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => NewChar(uuid: uid, name: 'Alpha Tester'))
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return alert;
                }
              );
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
                MaterialPageRoute(builder: (_) => const Home())
            );
          },
          child: const Text('Continue'),
        )
      ],
    );
  }
}
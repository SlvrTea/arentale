
import 'package:arentale/presentation/home.dart';
import 'package:arentale/presentation/locations/location.dart';
import 'package:arentale/presentation/login/new_char.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _NewGameButton(),
        _ContinueButton()
      ],
    );
  }
}

class _NewGameButton extends StatelessWidget {
  const _NewGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = Hive.box('userInfo');

    return ElevatedButton(
        onPressed: () {
          if (userInfo.containsKey('uuid')) {
            final uuid = userInfo.get('uuid');
            showDialog(
              context: context,
              builder: (context) {
                return _CharExistDialog(uuid: uuid);
              }
            );
          } else {
            final uuid = const Uuid().v1();
            userInfo.put('uuid', uuid);
            userInfo.put('location', 'slinskPrologue');
            userInfo.put('dialogId', 'd1.1');
            userInfo.put('tags', []);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => NewChar(uuid: uuid, name: 'Alpha Tester'))
            );
          }
        },
        child: const Text('Новая игра')
    );
  }
}

class _CharExistDialog extends StatelessWidget {
  final String uuid;
  const _CharExistDialog({super.key, required this.uuid});

  @override
  Widget build(BuildContext context) {
    final userInfo = Hive.box('userInfo');
    final okButton = ElevatedButton(
      child: const Text('Ok'),
      onPressed: () {
        userInfo.put('location', 'slinskPrologue');
        userInfo.put('dialogId', 'd1.1');
        userInfo.put('tags', []);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NewChar(uuid: uuid, name: 'Alpha Tester'))
        );
      },
    );
    final backButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Назад')
    );

    return AlertDialog(
      title: const Text('Персонаж уже существует'),
      content: const Text('Создание нового персонажа удалит существующего. Это дейстивие нельзя отменить.'),
      actions: [
        okButton,
        backButton
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = Hive.box('userInfo');
    return ElevatedButton(
        onPressed: () {
          if (userInfo.containsKey('uuid')) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const Home())
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Персонажа не существует'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Назад')
                    )
                  ],
                );
              }
            );
          }
        },
        child: const Text('Продолжить')
    );
  }
}
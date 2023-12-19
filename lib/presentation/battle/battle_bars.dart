
import 'package:arentale/domain/game/game_entities/game_object.dart';
import 'package:flutter/material.dart';

class HealthBar extends StatelessWidget {
  final GameObject char;
  const HealthBar({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (char.HP / char.maxHP),
      minHeight: 7,
      color: Colors.green,
    );
  }
}

class ManaBar extends StatelessWidget {
  final GameObject char;
  const ManaBar({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (char.MP / char.maxMP),
      minHeight: 7,
      color: Colors.blue,
    );
  }
}



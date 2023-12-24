
import 'package:arentale/domain/game/game_entities/game_object.dart';
import 'package:flutter/material.dart';

class HealthBar extends StatelessWidget {
  final GameObject char;
  const HealthBar({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        LinearProgressIndicator(
          value: (char.HP / char.maxHP),
          minHeight: 9,
          color: Colors.green,
        ),
        Text('${char.HP}/${char.maxHP}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ]
    );
  }
}

class ManaBar extends StatelessWidget {
  final GameObject char;
  const ManaBar({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        LinearProgressIndicator(
          value: (char.MP / char.maxMP),
          minHeight: 9,
          color: Colors.blue,
        ),
        Text('${char.MP}/${char.maxMP}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ]
    );
  }
}



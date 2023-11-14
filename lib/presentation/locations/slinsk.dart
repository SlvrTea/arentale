
import 'package:arentale/presentation/battle.dart';
import 'package:arentale/presentation/dialog.dart';
import 'package:arentale/presentation/dialog_option.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class Slinsk extends StatelessWidget {
  const Slinsk({super.key});

  @override
  Widget build(BuildContext context) {
    return GameDialog(
        options: [DialogOption(option: S.of(context).testBattle, result: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const Battle())
          );
        })],
        dialog: S.of(context).slinskD1
    );
  }
}

import 'package:arentale/presentation/dialog.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class Slinsk extends StatelessWidget {
  const Slinsk({super.key});

  @override
  Widget build(BuildContext context) {
    final slD = {
      'd1': {
        'msg': S.of(context).slinskD1,
        'options': {
          'o1': {
            'msg': S.of(context).slinskO1,
            'goto': 'd2'
          }
        }
      },
      'd2': {
        'msg': 'test',
        'options': {
          'o1': {
            'msg': 'test1',
            'goto': 'd1'
          },
          'o2': {
            'msg': 'test2',
            'goto': 'd1'
          }
        }
      }
    };

    return GameDialog(
        dialogTree: slD,
    );
  }
}
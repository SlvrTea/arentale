
import 'package:arentale/presentation/locations/location.dart';
import 'package:arentale/presentation/map_tile.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class Slinsk extends GameLocation {
  Slinsk({super.key, required super.initDialog,});

  @override
  Widget build(BuildContext context) {
    final slMap = {
      3: const MapTile(),
      6: const MapTile()
    };
    final slD = {
      'd1.1': {
        'msg': S.of(context).slinskD1,
        'options': {
          'o1': {
            'msg': S.of(context).slinskO1,
            'goto': 'd1.2'
          }
        }
      },
      'd1.2': {
        'msg': 'test',
        'options': {
          'o1': {
            'msg': 'test1',
            'goto': 'd1.1'
          },
          'o2': {
            'msg': 'test battle',
            'tags': [
              DialogTags.startBattle
            ],
          }
        }
      }
    };
    super.dialogTree = slD;
    super.locationMap = slMap;
    super.locationMobs = ['bat', 'boar'];
    return super.build(context);
  }
}
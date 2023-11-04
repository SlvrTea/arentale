
import 'package:arentale/domain/game/battle/battle_loop.dart';
import 'package:arentale/domain/game/game_object.dart';

import '../player/player.dart';

class BattleController {
  final Player player;
  final GameObject mob;
  final BattleLoop loop = BattleLoop();
  String log = '';

  BattleController(this.player, this.mob);

  void turn() {
    for (var element in loop.events) {
      if (mob.HP <= 0) {
        log += '\nВы победили!';
        break;
      } else if (player.HP <= 0) {
        log += '\nВы проиграли!';
        break;
      }
      log += element.ef();
    }
    loop.events = [];
  }
}
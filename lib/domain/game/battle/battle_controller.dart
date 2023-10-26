
import 'package:arentale/domain/game/game_object.dart';

import '../player/player.dart';

class BattleController {
  final Player player;
  final GameObject mob;

  BattleController(this.player, this.mob);
}
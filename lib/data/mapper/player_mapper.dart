
import 'package:arentale/domain/game/player/player.dart';
import '../player_db.dart';

class PlayerMapper {
  static Player fromDataBase(PlayerDB player) {
    return Player(
      info: player.info,
      stats: player.stats,
      inventory: player.inventory,
      equip: player.equip
    );
  }
}

import '../game/player/equip.dart';
import '../game/player/player.dart';
import '../game/stats.dart';

abstract class PlayerRepository {
  Future<Player> getPlayer(uuid);
}
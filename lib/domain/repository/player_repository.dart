
import '../game/player/equip.dart';
import '../game/player/player.dart';
import '../game/stats.dart';

abstract class PlayerRepository {
  Future<Player> getPlayer(uuid);

  Future<void> addItem(uuid, item, {amount = 1});

  Future<void> addExperience(uuid, value);

  Future<void> addGold(uuid, value);
}
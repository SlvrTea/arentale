
import '../game/player/player.dart';

abstract class PlayerRepository {
  Future<Player> getPlayer();

  Future<void> updateInfo({required String doc, required String field, required int value, String updateType = 'set'});
}

import '../../data/service/player_service.dart';
import '../game/player/player.dart';

abstract class PlayerRepository {
  Future<Player> getPlayer();

  Future<void> updateInfo({required String doc, required String field, required dynamic value, DataUpdateType updateType = DataUpdateType.set});

  Future<void> changeLocation(String location);
}
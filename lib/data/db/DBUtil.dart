
import 'package:arentale/data/mapper/player_mapper.dart';
import 'package:arentale/data/service/player_service.dart';
import '../../domain/game/player/player.dart';

class DBUtils {
  final PlayerService _playerService;

  DBUtils(this._playerService);

  Future<Player> getPlayer(uuid) async {
    final result = await _playerService.getPlayer(uuid);
    return PlayerMapper.fromDataBase(result);
  }
}
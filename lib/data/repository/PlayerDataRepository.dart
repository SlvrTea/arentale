
import 'package:arentale/data/db/DBUtil.dart';
import 'package:arentale/domain/game/player/equip.dart';
import 'package:arentale/domain/game/player/player.dart';
import 'package:arentale/domain/game/stats.dart';
import 'package:arentale/domain/repository/player_repository.dart';

class PlayerDataRepository extends PlayerRepository {
  final DBUtils _dbUtils;

  PlayerDataRepository(this._dbUtils);

  @override
  Future<Player> getPlayer(uuid) {
    return _dbUtils.getPlayer(uuid);
  }
}
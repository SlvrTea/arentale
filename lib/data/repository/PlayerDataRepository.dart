
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

  @override
  Future<void> addGold(uuid, value) async {
    _dbUtils.addGold(uuid, value);
  }

  @override
  Future<void> addExperience(uuid, value) async {
    _dbUtils.addExperience(uuid, value);
  }

  @override
  Future<void> addItem(uuid, item, {amount = 1}) async {
    _dbUtils.addItem(uuid, item, amount: amount);
  }
}
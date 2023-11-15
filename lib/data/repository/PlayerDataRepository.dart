
import 'package:arentale/data/db/DBUtil.dart';
import 'package:arentale/domain/game/player/player.dart';
import 'package:arentale/domain/repository/player_repository.dart';

class PlayerDataRepository extends PlayerRepository {
  final DBUtils _dbUtils;

  PlayerDataRepository(this._dbUtils);

  @override
  Future<Player> getPlayer() {
    return _dbUtils.getPlayer();
  }

  @override
  Future<void> updateInfo({required String doc, required String field, required int value, String updateType = 'set'}) {
    return _dbUtils.updateInfo(doc: doc, field: field, value: value, updateType: updateType);
  }
}
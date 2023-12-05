
import 'package:arentale/data/db/DBUtil.dart';
import 'package:arentale/domain/game/player/player.dart';
import 'package:arentale/domain/repository/player_repository.dart';

import '../service/player_service.dart';

class PlayerDataRepository extends PlayerRepository {
  final DBUtils _dbUtils;

  PlayerDataRepository(this._dbUtils);

  @override
  Future<Player> getPlayer() {
    return _dbUtils.getPlayer();
  }

  @override
  Future<void> updateInfo({required String doc, required String field, required dynamic value, DataUpdateType updateType = DataUpdateType.set}) {
    return _dbUtils.updateInfo(doc: doc, field: field, value: value, updateType: updateType);
  }

  @override
  Future<void> changeLocation(String location) {
    return _dbUtils.changeLocation(location);
  }
}

import 'package:arentale/data/db/DBUtil.dart';
import 'package:arentale/data/service/inventory_service.dart';
import 'package:arentale/data/service/mob_service.dart';
import 'package:arentale/data/service/player_service.dart';

class DataBaseModule {
  static DBUtils? _dbUtils;

  static dbUtil() {
    _dbUtils ??= DBUtils(PlayerService(), MobService(), InventoryService());
    return _dbUtils;
  }
}
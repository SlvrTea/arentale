
import 'package:arentale/domain/repository/mob_repositry.dart';

import '../../domain/game/mob.dart';
import '../db/DBUtil.dart';

class MobDataRepository extends MobRepository {
  final DBUtils _dbUtils;

  MobDataRepository(this._dbUtils);

  @override
  Future<Mob> getMob(String mobId) {
    return _dbUtils.getMob(mobId);
  }
}
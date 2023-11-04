
import 'package:arentale/data/mob_db.dart';
import 'package:arentale/domain/game/mob.dart';

class MobMapper {
  static Mob fromDatabase(MobDB mob) {
    return Mob(
      stats: mob.stats,
      info: mob.info
    );
  }
}

import '../game/mob.dart';

abstract class MobRepository {
  Future<Mob> getMob(String mobId);
}
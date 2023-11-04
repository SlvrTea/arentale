
import 'package:arentale/data/mapper/mob_mapper.dart';
import 'package:arentale/data/mapper/player_mapper.dart';
import 'package:arentale/data/service/player_service.dart';
import '../../domain/game/mob.dart';
import '../../domain/game/player/player.dart';
import '../service/mob_service.dart';

class DBUtils {
  final PlayerService _playerService;
  final MobService _mobService;

  DBUtils(this._playerService, this._mobService);

  Future<Player> getPlayer(uuid) async {
    final result = await _playerService.getPlayer(uuid);
    return PlayerMapper.fromDataBase(result);
  }

  Future<Mob> getMob(mobId) async {
    final result = await _mobService.getMob(mobId);
    return MobMapper.fromDatabase(result);
  }
}
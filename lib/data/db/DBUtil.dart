
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

  Future<Player> getPlayer() async {
    final result = await _playerService.getPlayer();
    return PlayerMapper.fromDataBase(result);
  }


  Future<void> updateInfo({required String doc, required String field, required dynamic value, DataUpdateType updateType = DataUpdateType.set}) async {
    _playerService.changeInfo(doc: doc, field: field, value: value, updateType: updateType);
  }

  Future<void> changeLocation(String location) async {
    _playerService.changeLocation(location);
  }

  Future<Mob> getMob(mobId) async {
    final result = await _mobService.getMob(mobId);
    return MobMapper.fromDatabase(result);
  }
}
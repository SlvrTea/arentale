
import 'package:arentale/data/mapper/mob_mapper.dart';
import 'package:arentale/data/mapper/player_mapper.dart';
import 'package:arentale/data/service/player_service.dart';
import '../../domain/game/mob.dart';
import '../../domain/game/player/player.dart';
import '../service/inventory_service.dart';
import '../service/mob_service.dart';

class DBUtils {
  final PlayerService _playerService;
  final MobService _mobService;
  final InventoryService _inventoryService;

  DBUtils(this._playerService, this._mobService, this._inventoryService);

  Future<Player> getPlayer() async {
    final result = await _playerService.getPlayer();
    return PlayerMapper.fromDataBase(result);
  }

  Future<Mob> getMob(mobId) async {
    final result = await _mobService.getMob(mobId);
    return MobMapper.fromDatabase(result);
  }

  Future<void> updateInfo({required String doc, required String field, required dynamic value, DataUpdateType updateType = DataUpdateType.set}) async {
    _playerService.changeInfo(doc: doc, field: field, value: value, updateType: updateType);
  }

  Future<void> changeLocation(String location) => _playerService.changeLocation(location);

  Future<void> changeClass(String newClass) => _playerService.changeClass(newClass);

  Future<Map<String, dynamic>> getInventory() => _inventoryService.getInventory();

  Future<Map<String, dynamic>> getAllItems() => _inventoryService.getAllItems();

  void addItems(List<String> items) => _inventoryService.addItems(items);

  void removeItems(List<String> items) => _inventoryService.removeItems(items);

  void changeEquip(String slot, String newItem) => _inventoryService.changeEquip(slot, newItem);

}
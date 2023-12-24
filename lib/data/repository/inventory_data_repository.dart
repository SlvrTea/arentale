
import 'package:arentale/data/db/DBUtil.dart';
import 'package:arentale/domain/repository/inventory_repository.dart';

class InventoryDataRepository extends InventoryRepository {
  final DBUtils _dbUtils;

  InventoryDataRepository(this._dbUtils);

  @override
  Future<Map<String, dynamic>> getInventory() => _dbUtils.getInventory();

  @override
  Future<Map<String, dynamic>> getAllItems() => _dbUtils.getAllItems();

  @override
  void addItems(List<String> items) => _dbUtils.addItems(items);

  @override
  void changeEquip(String slot, String newItem) => _dbUtils.changeEquip(slot, newItem);

  @override
  void removeItems(List<String> items) => _dbUtils.removeItems(items);
}

abstract class InventoryRepository {
  Future<Map<String, dynamic>> getInventory();

  Future<Map<String, dynamic>> getAllItems();

  void changeEquip(String slot, String newItem);

  void addItems(List<String> items);

  void removeItems(List<String> items);
}
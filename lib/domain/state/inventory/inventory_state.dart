part of 'inventory_bloc.dart';

@immutable
abstract class InventoryState {}

class InventoryInitial extends InventoryState {}

class InventoryLoadingState extends InventoryState {}

class InventoryLoadedState extends InventoryState {
  final Map inventory;

  InventoryLoadedState(this.inventory);
}

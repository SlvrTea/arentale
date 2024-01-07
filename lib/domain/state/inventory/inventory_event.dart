part of 'inventory_bloc.dart';

@immutable
abstract class InventoryEvent {}

class InventoryGetEvent extends InventoryEvent {}
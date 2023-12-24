part of '../../state/equip/equip_bloc.dart';

@immutable
abstract class EquipEvent {}

class EquipChangeEvent extends EquipEvent {
  final String slot;
  final String item;

  EquipChangeEvent({required this.slot, required this.item});
}

class EquipGetValidEvent extends EquipEvent {
  final String slot;

  EquipGetValidEvent(this.slot);
}

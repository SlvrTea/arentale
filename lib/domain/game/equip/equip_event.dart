part of 'equip_bloc.dart';

@immutable
abstract class EquipEvent {}

class EquipChangeEvent extends EquipEvent {
  final EquipItem oldItem;
  final String item;

  EquipChangeEvent({required this.oldItem, required this.item});
}

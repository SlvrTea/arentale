part of 'equip_bloc.dart';

@immutable
abstract class EquipState {}

class EquipInitial extends EquipState {}

class EquipValidState extends EquipState {
  final List<Widget> validEquip;

  EquipValidState(this.validEquip);
}

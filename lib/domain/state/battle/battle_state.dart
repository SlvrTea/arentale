part of 'battle_bloc.dart';

@immutable
abstract class BattleState {}

class BattleInitial extends BattleState {}

class BattleLoadingState extends BattleState {}

class BattleLoadedState extends BattleState {
  Player player;
  GameObject mob;
  BattleController battleController;

  BattleLoadedState(this.player, this.mob, this.battleController);
}

class BattleEndState extends BattleState {
  final String log;

  BattleEndState(this.log);
}

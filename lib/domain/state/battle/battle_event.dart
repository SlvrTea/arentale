part of 'battle_bloc.dart';

@immutable
abstract class BattleEvent {}

class BattleLoadingEvent extends BattleEvent {
  String mob;

  BattleLoadingEvent(this.mob);
}

class BattleLoadedEvent extends BattleEvent {}

class BattleLogUpdateEvent extends BattleEvent {
  BattleState currentState;

  BattleLogUpdateEvent(this.currentState);
}

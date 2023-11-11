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

class BattleEndEvent extends BattleEvent {
  final int exp;
  final int gold;
  final List drop;
  final String log;

  BattleEndEvent(this.drop, this.exp, this.gold, this.log);
}

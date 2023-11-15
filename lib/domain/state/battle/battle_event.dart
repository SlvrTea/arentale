part of 'battle_bloc.dart';


abstract class BattleEvent {}

class BattleLoadingEvent extends BattleEvent {
  String mob;
  PlayerModel playerModel;

  BattleLoadingEvent(this.mob, this.playerModel);
}

class BattleLoadedEvent extends BattleEvent {}

class BattleLogUpdateEvent extends BattleEvent {
  BattleState currentState;

  BattleLogUpdateEvent(this.currentState);
}

class BattleEndEvent extends BattleEvent {
  final String log;

  BattleEndEvent(this.log);
}

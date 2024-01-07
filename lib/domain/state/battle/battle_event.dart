part of 'battle_bloc.dart';


abstract class BattleEvent {}

class BattleLoadingEvent extends BattleEvent {
  final String mob;
  final PlayerCubit playerCubit;

  BattleLoadingEvent(this.mob, this.playerCubit);
}

class BattleLoadedEvent extends BattleEvent {}

class BattleLogUpdateEvent extends BattleEvent {
  final BattleState currentState;

  BattleLogUpdateEvent(this.currentState);
}

class BattleEndEvent extends BattleEvent {
  final String log;

  BattleEndEvent(this.log);
}

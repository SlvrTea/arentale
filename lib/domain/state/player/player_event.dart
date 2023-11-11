part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {}

class PlayerGetPlayerEvent extends PlayerEvent {}

class PlayerStartBattleEvent extends PlayerEvent {}

class PlayerAddExpEvent extends PlayerEvent {
  final int value;
  final int currentExp;
  final int currentLevel;

  PlayerAddExpEvent(this.value, this.currentExp, this.currentLevel);
}

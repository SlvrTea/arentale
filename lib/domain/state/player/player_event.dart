part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {}

class PlayerGetPlayerEvent extends PlayerEvent {}

class PlayerStartBattleEvent extends PlayerEvent {}

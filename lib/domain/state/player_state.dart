part of 'player_bloc.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoaded extends PlayerState {
  Player player;

  PlayerLoaded(this.player);
}

class PlayerLoading extends PlayerState {}

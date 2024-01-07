part of 'player_cubit.dart';

@immutable
abstract class PlayerState {
  Player get player;
}

class PlayerLoadingState extends PlayerState {
  @override
  Player get player => throw UnimplementedError();
}

class PlayerLoadedState extends PlayerState {
  final Player _player;

  PlayerLoadedState({required Player player}) : _player = player;

  @override
  Player get player => _player;
}
import 'dart:async';

import 'package:arentale/domain/game/game_object.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../internal/dependencies/repository_module.dart';
import '../../game/battle/battle_controller.dart';
import '../../game/player/player.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerInitial()) {
    on<PlayerGetPlayerEvent>(_onGetPlayer);
  }

  _onGetPlayer(PlayerGetPlayerEvent event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading());
    final pref = await SharedPreferences.getInstance();
    Player player = await RepositoryModule.playerRepository().getPlayer(pref.getString('uid'));
    emit(PlayerLoaded(player));
  }
}

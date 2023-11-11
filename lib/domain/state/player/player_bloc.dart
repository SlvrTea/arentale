import 'dart:async';
import 'dart:math';

import 'package:arentale/data/service/player_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../internal/dependencies/repository_module.dart';
import '../../game/player/player.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerInitial()) {
    on<PlayerGetPlayerEvent>(_onGetPlayer);
    on<PlayerAddExpEvent>(_onAddExp);
  }

  _onGetPlayer(PlayerGetPlayerEvent event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading());
    final pref = await SharedPreferences.getInstance();
    Player player = await RepositoryModule.playerRepository().getPlayer(pref.getString('uid'));
    emit(PlayerLoaded(player));
  }

  _onAddExp(PlayerAddExpEvent event, Emitter<PlayerState> emit) async {
    final perf = await SharedPreferences.getInstance();
    final uuid = perf.getString('uid');
    final playerService = PlayerService();
    if ((event.currentExp + event.value) > (100 * pow(event.currentLevel, 0.8)).round()) {
      final e = (event.currentExp + event.value) - (100 * pow(event.currentLevel, 0.8)).round();
      playerService.setExperience(uuid!, e);
      playerService.levelUp(uuid);
    } else {
      playerService.addExperience(uuid!, event.value);
    }
  }
}

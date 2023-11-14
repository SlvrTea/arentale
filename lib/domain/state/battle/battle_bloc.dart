import 'dart:async';
import 'dart:math';

import 'package:arentale/data/service/player_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../internal/dependencies/repository_module.dart';
import '../../game/battle/battle_controller.dart';
import '../../game/game_object.dart';
import '../../game/mob.dart';
import '../../game/player/player.dart';

part 'battle_event.dart';
part 'battle_state.dart';

class BattleBloc extends Bloc<BattleEvent, BattleState> {
  BattleBloc() : super(BattleInitial()) {
    on<BattleLoadingEvent>(_onBattleLoadingEvent);
    on<BattleLogUpdateEvent>(_onBattleLogUpdateEvent);
    on<BattleEndEvent>(_onBattleEndEvent);
  }

  _onBattleLoadingEvent(BattleLoadingEvent event, Emitter emit) async {
    emit(BattleLoadingState());
    final pref = await SharedPreferences.getInstance();
    Player player = await RepositoryModule.playerRepository().getPlayer(pref.getString('uid'));
    Mob mob = await RepositoryModule.mobRepository().getMob(event.mob);
    emit(BattleLoadedState(player, mob, BattleController(player, mob)));
  }

  _onBattleLogUpdateEvent(BattleLogUpdateEvent event, Emitter emit) {
    emit(BattleLoadingState());
    emit(event.currentState);
  }

  _onBattleEndEvent(BattleEndEvent event, Emitter emit) async {
    emit(BattleEndState(event.log));
    final perf = await SharedPreferences.getInstance();
    final uuid = perf.getString('uid')!;
    final playerRepository = RepositoryModule.playerRepository();
    await playerRepository.addGold(uuid, event.gold).whenComplete(() => playerRepository.addExperience(uuid, event.exp));

    if (event.drop.isNotEmpty) {
      for (var element in event.drop) {
        await playerRepository.addItem(uuid, element);
      }
    }
  }
}

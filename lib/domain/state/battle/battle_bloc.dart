
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../internal/dependencies/repository_module.dart';
import '../../game/battle/battle_controller.dart';
import '../../game/game_entities/game_object.dart';
import '../../game/mob.dart';
import '../../game/player/player.dart';
import '../../player_model.dart';

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
    Player player = await RepositoryModule.playerRepository().getPlayer();
    Mob mob = await RepositoryModule.mobRepository().getMob(event.mob);
    emit(BattleLoadedState(player, mob, BattleController(player, mob, event.playerModel)));
  }

  _onBattleLogUpdateEvent(BattleLogUpdateEvent event, Emitter emit) {
    emit(BattleLoadingState());
    emit(event.currentState);
  }

  _onBattleEndEvent(BattleEndEvent event, Emitter emit) {
    emit(BattleEndState(event.log));
  }
}

import 'dart:async';

import 'package:arentale/domain/player_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'equip_item.dart';

part 'equip_event.dart';
part 'equip_state.dart';

class EquipBloc extends Bloc<EquipEvent, EquipState> {
  final PlayerModel playerModel;
  EquipBloc({required this.playerModel}) : super(EquipInitial()) {
    on<EquipChangeEvent>(_onEquipChange);
  }

  _onEquipChange(EquipChangeEvent event, Emitter emit) async {

  }
}

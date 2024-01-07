import 'dart:async';

import 'package:arentale/domain/const.dart';
import 'package:arentale/domain/game/equip/equip_item.dart';
import 'package:arentale/internal/dependencies/repository_module.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../presentation/equip_screen.dart';
import '../../repository/inventory_repository.dart';

part 'equip_event.dart';
part 'equip_state.dart';

class EquipBloc extends Bloc<EquipEvent, EquipState> {
  final InventoryRepository inventoryRepository = RepositoryModule.inventoryRepository();
  EquipBloc() : super(EquipInitial()) {
    on<EquipChangeEvent>(_onEquipChange);
    on<EquipGetValidEvent>(_onGetValid);
  }

  _onEquipChange(EquipChangeEvent event, Emitter emit) async {
    inventoryRepository.changeEquip(event.slot, event.item);
    emit(EquipInitial());
  }

  _onGetValid(EquipGetValidEvent event, Emitter emit) async {
    final allItems = await inventoryRepository.getAllItems();
    final inv = await inventoryRepository.getInventory();
    final valid = <Widget>[];
    for (var item in inv.keys) {
      if (allItems[item]['type'] != 'cons' && allItems[item]['slot'].contains(event.slot)) {
        valid.add(
          EquipTile(
            EquipItem.fromJson(allItems, item),
            onTap: () {
              add(EquipChangeEvent(slot: event.slot, item: item));
              navigatorKey.currentState!.pop();
            },
          )
        );
      }
    }
    emit(EquipValidState(valid));
  }
}

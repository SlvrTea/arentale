import 'dart:async';

import 'package:arentale/internal/dependencies/repository_module.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../repository/inventory_repository.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepository invRepo = RepositoryModule.inventoryRepository();
  InventoryBloc() : super(InventoryInitial()) {
    on<InventoryGetEvent>(_getInv);
  }

  _getInv(InventoryGetEvent event, Emitter emit) async {
    emit(InventoryLoadingState());
    final invRaw = await invRepo.getInventory();
    final allItems = await invRepo.getAllItems();
    final inv = {};
    for (var key in invRaw.keys) {
      inv.addAll({allItems[key]['name']: invRaw[key]});
    }
    emit(InventoryLoadedState(inv));
  }
}

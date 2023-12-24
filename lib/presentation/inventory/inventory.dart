
import 'package:arentale/domain/state/inventory/inventory_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<InventoryBloc>();
    final state = bloc.state;
    if (state is InventoryLoadedState) {
      var items = state.inventory.keys.toList();
      return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: state.inventory.keys.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}: ${state.inventory[items[index]]}'),
            );
          }
        ),
      );
    }
    bloc.add(InventoryGetEvent());
    return const Center(child: CircularProgressIndicator());
  }
}
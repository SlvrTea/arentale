
import 'package:arentale/presentation/map_tile.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  final Map<int, Widget> map;
  const MapScreen({super.key, required this.map});
  
  List<Widget> _buildMap() {
    final List<Widget> result = List.filled(35, const MapTile());
    for (var e in map.keys) {
      result[e] = map[e]!;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GridView.count(
        crossAxisSpacing: 5,
        crossAxisCount: 5,
        mainAxisSpacing: 5,
        children: _buildMap()
      ),
    );
  }
}

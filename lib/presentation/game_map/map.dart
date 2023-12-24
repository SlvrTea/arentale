
import 'package:arentale/presentation/game_map/map_tile.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  final Map<int, Widget> map;

  const MapScreen({super.key, required this.map});

  List<Widget> _buildMap() {
    final List<Widget> result = List.filled(
        35, MapTile(tileTexture: Image.asset('assets/blank_icon.png')));
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
          crossAxisSpacing: 3,
          crossAxisCount: 5,
          mainAxisSpacing: 3,
          children: _buildMap()
      ),
    );
  }
}

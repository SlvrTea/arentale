
import 'package:flutter/material.dart';

class StatElement extends StatelessWidget {
  const StatElement({super.key, required this.statName, required this.statValue});
  final String statName;
  final String statValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(statName),
        subtitle: Text(statValue),
      ),
    );
  }

}
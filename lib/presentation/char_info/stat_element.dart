
import 'package:flutter/material.dart';

class StatElement extends StatelessWidget {
  final String statName;
  final String statValue;
  final Widget? leading;

  const StatElement({super.key, required this.statName, required this.statValue, this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$statName: $statValue'),
      leading: leading,
    );
  }
}
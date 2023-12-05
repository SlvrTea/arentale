
import 'package:flutter/material.dart';

class MapTile extends StatelessWidget {
  final void Function()? onTap;
  const MapTile({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.green,
      ),
    );
  }
}

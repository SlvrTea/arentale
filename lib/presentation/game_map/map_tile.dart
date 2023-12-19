
import 'package:flutter/material.dart';

class MapTile extends StatelessWidget {
  final void Function()? onTap;
  final String? tooltip;
  final Image? tileTexture;
  final Color? color;

  const MapTile({super.key, this.onTap, this.tileTexture, this.color, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (tooltip != null) {
          final SnackBar tooltipBar = SnackBar(content: Text(tooltip!));
          ScaffoldMessenger.of(context).showSnackBar(tooltipBar);
        }
      },
      onTap: onTap,
      child: tileTexture ?? Container(
        color: color,
      ),
    );
  }
}


import 'package:arentale/domain/const.dart';
import 'package:arentale/domain/state/dialog/dialog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapTile extends StatelessWidget {
  final void Function()? onTap;
  final String? toDialog;
  final String? tooltip;
  final Image? tileTexture;
  final Color? color;

  const MapTile({super.key, this.onTap, this.tileTexture, this.color, this.tooltip, this.toDialog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (tooltip != null) {
          final SnackBar tooltipBar = SnackBar(content: Text(tooltip!));
          ScaffoldMessenger.of(context).showSnackBar(tooltipBar);
        }
      },
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
        if (toDialog != null) {
          BlocProvider.of<DialogCubit>(context, listen: false).pushDialog(toDialog!);
          navigatorKey.currentState!.pop();
        }
      },
      child: tileTexture ?? Container(color: color),
    );
  }
}

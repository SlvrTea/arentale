
import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  final String option;
  final void Function() result;
  const DialogOption({super.key, required this.option, required this.result});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: result,
      child: Text(option)
    );
  }
}

import 'package:flutter/material.dart';

class DialogOption extends StatefulWidget {
  final String option;
  final void Function() result;
  const DialogOption({super.key, required this.option, required this.result});

  @override
  State<DialogOption> createState() => _DialogOptionState();
}

class _DialogOptionState extends State<DialogOption> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.result,
      child: Text(widget.option)
    );
  }
}
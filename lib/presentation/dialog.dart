
import 'package:flutter/material.dart';

class GameDialog extends StatefulWidget {
  List<Widget> options;
  String dialog;

  GameDialog({required this.options, required this.dialog, super.key});

  @override
  State<GameDialog> createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getDialog(widget.dialog, MediaQuery.of(context).size.height * 0.7, MediaQuery.of(context).size.width),
        ...widget.options
      ],
    );
  }

  Widget _getDialog(String dialog,double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(dialog),
          ),
        ),
      ),
    );
  }

  void push(String dialog, List<Widget> options) {
    setState(() {
      widget.options = options;
      widget.dialog = dialog;
    });
  }
}
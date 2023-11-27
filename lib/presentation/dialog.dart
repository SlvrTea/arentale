
import 'package:arentale/presentation/dialog_option.dart';
import 'package:flutter/material.dart';

class GameDialog extends StatefulWidget {
  final Map dialogTree;

  const GameDialog({required this.dialogTree, super.key});

  @override
  State<GameDialog> createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  late String dialog;
  late List options;

  void pushDialog(String dialogID) {
    setState(() {
      buildDialog(dialogID);
    });
  }

  void buildDialog(String dialogID) {
    dialog = widget.dialogTree[dialogID]['msg'];
    options = widget.dialogTree[dialogID]['options'].keys.map((e) => DialogOption(
        option: widget.dialogTree[dialogID]['options'][e]['msg'],
        result: () {
          pushDialog(widget.dialogTree[dialogID]['options'][e]['goto']);
        }
    )).toList();
  }

  @override
  void initState() {
    buildDialog('d1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getDialog(dialog, MediaQuery.of(context).size.height * 0.65, MediaQuery.of(context).size.width),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [...options],
          )
        ],
      ),
    );
  }

  Widget _getDialog(String dialog, double height, double width) {
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
}
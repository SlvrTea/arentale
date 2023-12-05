
import 'package:arentale/presentation/dialog_option.dart';
import 'package:flutter/material.dart';

class GameDialog extends StatefulWidget {
  final Map dialogTree;
  final String initDialog;

  const GameDialog({super.key, required this.dialogTree, required this.initDialog});

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
          if (widget.dialogTree[dialogID]['options'][e].containsKey('onSelect')) {
            widget.dialogTree[dialogID]['options'][e]['onSelect'].forEach((e) => e());
          }
          if (widget.dialogTree[dialogID]['options'][e].containsKey('goto')) {
            pushDialog(widget.dialogTree[dialogID]['options'][e]['goto']);
          }
        }
    )).toList();
  }

  @override
  void initState() {
    buildDialog(widget.initDialog);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getDialog(dialog, MediaQuery.of(context).size.height * 0.65, MediaQuery.of(context).size.width),
          SizedBox(
            height: 100,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [...options],
              ),
            ),
          ),
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
            child: Text(
              dialog,
              style: const TextStyle(fontSize: 16)
            ),
          ),
        ),
      ),
    );
  }
}
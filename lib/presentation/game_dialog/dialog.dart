
import 'package:arentale/presentation/game_dialog/dialog_option.dart';
import 'package:arentale/presentation/locations/location.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GameDialog extends StatefulWidget {
  final Map dialogTree;
  String initDialog;

  GameDialog({super.key, required this.dialogTree, required this.initDialog});

  @override
  State<GameDialog> createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  late String dialog;
  late List<Widget> options;
  final userInfo = Hive.box('userInfo');

  void pushDialog(String dialogID) {
    userInfo.put('dialogId', dialogID);
    setState(() {
      buildDialog(dialogID);
    });
  }

  bool isValid(PlayerTags tag) {
    final playerTags = userInfo.get('tags');
    if (playerTags.contains(tag)) {
      return true;
    }
    return false;
  }

  void addTag(List<PlayerTags> tags) {
    final List userTags = userInfo.get('tags');
    for (var element in tags) {
      userTags.add(element);
    }
  }

  List<Widget> getOptions(String dialogID) {
    final List<Widget> result = [];
    for (var e in widget.dialogTree[dialogID]['options'].keys) {
      if (widget.dialogTree[dialogID]['options'][e].containsKey('required')) {
        if (!widget.dialogTree[dialogID]['options'][e]['required'].every(isValid)) {
          continue;
        }
      }
      result.add(DialogOption(
          option: widget.dialogTree[dialogID]['options'][e]['msg'],
          result: () {
            if (widget.dialogTree[dialogID]['options'][e].containsKey('onSelect')) {
              widget.dialogTree[dialogID]['options'][e]['onSelect'].forEach((e) => e());
            }
            if (widget.dialogTree[dialogID]['options'][e].containsKey('goto')) {
              pushDialog(widget.dialogTree[dialogID]['options'][e]['goto']);
            }
            if (widget.dialogTree[dialogID]['options'][e].containsKey('add')) {
              addTag(e['add']);
            }
          }
      ));
    }
    return result;
  }

  void buildDialog(String dialogID) {
    dialog = widget.dialogTree[dialogID]['msg'];
    options = getOptions(dialogID);
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
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: options,
                ),
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
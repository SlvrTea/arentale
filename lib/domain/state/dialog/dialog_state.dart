part of 'dialog_cubit.dart';

@immutable
abstract class DialogState {
  final String dialogId;

  const DialogState(this.dialogId);
}

class DialogText extends DialogState {
  const DialogText(super.dialogId);
}

class DialogOptions extends DialogState {
  const DialogOptions(super.dialogId);
}
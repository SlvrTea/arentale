
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'dialog_state.dart';

class DialogCubit extends Cubit<DialogState> {
  final userInfo = Hive.box('userInfo');
  DialogCubit() : super(DialogText(Hive.box('userInfo').get('dialogId')));

  void pushDialog(String toDialog) {
    emit(DialogText(toDialog));
    userInfo.put('dialogId', toDialog);
  }

  void showText(String id) => emit(DialogText(id));

  void showOptions(String id) => emit(DialogOptions(id));
}

import 'package:bloc/bloc.dart';

class DialogCubit extends Cubit<String> {
  String dialogId;
  DialogCubit(this.dialogId) : super(dialogId);

  void pushDialog(String toDialog) => emit(toDialog);
}

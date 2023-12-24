import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DialogCubit extends Cubit<String> {
  final userInfo = Hive.box('userInfo');
  DialogCubit() : super(Hive.box('userInfo').get('dialogId'));

  void pushDialog(String toDialog) {
    emit(toDialog);
    userInfo.put('dialogId', toDialog);
  }
}

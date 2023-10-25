
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationChangeEvent, int>{
  NavigationBloc() : super(0) {
    on<NavigationChangeEvent>(_onChange);
  }

  _onChange(NavigationChangeEvent event, Emitter<int> emit) {
    emit(state - state + event.value);
  }
}

class NavigationChangeEvent {
  int value;
  NavigationChangeEvent({required this.value});
}
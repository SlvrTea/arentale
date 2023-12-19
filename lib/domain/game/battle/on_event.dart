
import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/game_entities/effect.dart';
import 'package:arentale/domain/game/game_entities/game_object.dart';

abstract class EventListener {
  final Type _listenedEvent = BattleEvent;
  void notify(BattleEvent event) {
    if (event.runtimeType == _listenedEvent){
      ef(char: event.char!);
    }
  }
  void ef({required GameObject char, GameObject? target});
}

class Bonecrusher extends EventListener {
  @override
  Type get _listenedEvent => OnCrit;

  @override
  void ef({required GameObject char, GameObject? target}) {
    char.applyEffect(BonecrusherAura(char: char));
  }
}

class Advantage extends EventListener {
  @override
  void ef({required GameObject char, GameObject? target}) {
    target!.takeDamage((char.ATK * 0.3).round());
  }
}
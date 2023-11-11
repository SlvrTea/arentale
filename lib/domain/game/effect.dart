
import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/game_object.dart';

abstract class Effect {
  GameObject char;
  String name;
  String tooltip;
  String iconPath;
  int stack;
  int duration;
  int maxStack;

  Effect({
    required this.char,
    required this.name,
    required this.tooltip,
    required this.iconPath,
    required this.duration,
    required this.maxStack,
    required this.stack
  });

  BattleEvent tick();
}

class Poison extends Effect {
  GameObject target;
  Poison({
    required super.char,
    required this.target,
    super.name = 'Poison',
    super.tooltip = '',
    super.iconPath = '',
    super.duration = 3,
    super.maxStack = 3,
    super.stack = 1
  });

  get damage => (char.ATK * 0.2 * stack).round();

  @override
  BattleEvent tick() {
    duration -= 1;
    if (duration <= 0) {
      target.effects.remove(this);
    }
    return DamageTick(
        {'message': '\nPoison: $damage', 'damage':damage},
        target
    );
  }
}

class ToxicVaporAura extends Effect {
  GameObject target;
  ToxicVaporAura({
    required super.char,
    required this.target,
    super.name = 'Toxic vapor',
    super.tooltip = '',
    super.iconPath = '',
    super.duration = 3,
    super.maxStack = 1,
    super.stack = 1
  });

  @override
  BattleEvent tick() {
    duration -= 1;
    if (duration <= 0) {
      target.effects.remove(this);
    }
    target.applyEffect(Poison(char: char, target: target));
    return AuraTick();
  }
}
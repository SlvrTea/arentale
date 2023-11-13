
import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/game/stat_modifier.dart';

abstract class Duration {
  void _decreaseDuration();
}

abstract class Effect implements Duration {
  final GameObject char;
  final String name;
  final String tooltip;
  final String iconPath;
  int duration;
  int stack;
  final int maxStack;

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

abstract class DamageOnTickEffect extends Effect {
  final GameObject target;
  DamageOnTickEffect({
    required super.char,
    required this.target,
    required super.name,
    required super.tooltip,
    required super.iconPath,
    required super.duration,
    required super.maxStack,
    required super.stack
  });

  int get damage;

  @override
  void _decreaseDuration() {
    duration -= 1;
    if (duration <= 0) {
      target.effects.remove(this);
    }
  }

  @override
  BattleEvent tick() {
    _decreaseDuration();
    return DamageTick(
        {'message': '\n$name: $damage', 'damage':damage},
        target
    );
  }
}

abstract class Aura extends Effect {
  Aura({
    required super.char,
    required super.name,
    required super.tooltip,
    required super.iconPath,
    required super.duration,
    required super.maxStack,
    required super.stack,
  });

  @override
  void _decreaseDuration() {
    duration -= 1;
    if (duration <= 0) {
      char.effects.remove(this);
    }
  }

  @override
  BattleEvent tick() {
    _decreaseDuration();
    return AuraTick();
  }
}

abstract class StatModifierAura extends Aura {
  final StatModifier modifier;
  StatModifierAura({
    required super.char,
    required this.modifier,
    required super.name,
    required super.tooltip,
    required super.iconPath,
    required super.duration,
    required super.maxStack,
    required super.stack
  }) {
    initial();
  }

  void initial();

  void onExpire();

  @override
  void _decreaseDuration() {
    duration -= 1;
    if (duration <= 0) {
      onExpire();
      char.effects.remove(this);
    }
  }
}

class Poison extends DamageOnTickEffect {
  Poison({
    required super.char,
    required super.target,
    super.name = 'Poison',
    super.tooltip = '',
    super.iconPath = '',
    super.duration = 3,
    super.maxStack = 3,
    super.stack = 1
  });

  @override
  get damage => (char.ATK * 0.2 * stack).round();
}

class ToxicVaporAura extends Aura {
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
    target.applyEffect(Poison(char: char, target: target));
    return super.tick();
  }
}

class Superiority extends Aura {
  Superiority({
    required super.char,
    super.name = 'Superiority',
    super.tooltip = '',
    super.iconPath = 'assets/superiority.jpg',
    super.duration = 99,
    super.maxStack = 1,
    super.stack = 1
  });
}

class SwiftRushAura extends StatModifierAura {
  SwiftRushAura({
    required super.char,
    super.modifier = const StatModifier(0.15),
    super.name = 'Swift Rush',
    super.tooltip = '',
    super.iconPath = 'assets/swift_rush.jpg',
    super.duration = 3,
    super.maxStack = 1,
    super.stack = 1
  });

  @override
  void initial() {
    char.critChance.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.critChance.removeModifier(modifier);
  }
}

class BonecrusherAura extends StatModifierAura {
  BonecrusherAura({
    required super.char,
    super.modifier = const StatModifier(0.01),
    super.name = 'Bonecrusher',
    super.tooltip = '',
    super.iconPath = 'assets/swift_rush.jpg',
    super.duration = 99,
    super.maxStack = 15,
    super.stack = 1
  });

  @override
  void initial() {
    char.critChance.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.critChance.removeModifier(modifier);
  }
}
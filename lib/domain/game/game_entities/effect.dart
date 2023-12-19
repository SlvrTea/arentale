
import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/game_entities/game_object.dart';
import 'package:arentale/domain/game/game_entities/stat.dart';
import 'package:arentale/domain/game/game_entities/stat_modifier.dart';

abstract class Duration {
  void _decreaseDuration();
}

abstract class Effect implements Duration {
  final GameObject char;
  final String name;
  final String iconPath;
  int duration;
  int stack;
  final int maxStack;

  Effect({
    required this.char,
    required this.name,
    required this.iconPath,
    required this.duration,
    required this.maxStack,
    this.stack = 1
  });

  String get tooltip;

  BattleEvent tick();
}

abstract class DamageOnTickEffect extends Effect {
  final GameObject target;
  DamageOnTickEffect({
    required super.char,
    required this.target,
    required super.name,
    required super.iconPath,
    required super.duration,
    required super.maxStack,
    super.stack = 1
  });

  @override
  String get tooltip;

  int get damage;

  @override
  void _decreaseDuration() {
    duration -= 1;
  }

  @override
  BattleEvent tick() {
    _decreaseDuration();
    return DamageTick(
        {'message': '\n🟢$name: $damage', 'damage':damage},
        target
    );
  }
}

abstract class Aura extends Effect {
  Aura({
    required super.char,
    required super.name,
    required super.iconPath,
    required super.duration,
    required super.maxStack,
    super.stack = 1
  });

  @override
  String get tooltip;

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
    required super.iconPath,
    required super.duration,
    required super.maxStack,
    super.stack = 1
  }) {
    initial();
  }

  @override
  String get tooltip;

  void initial();

  void onExpire();

  @override
  void _decreaseDuration() {
    duration -= 1;
    if (duration <= 0) {
      onExpire();
    }
  }
}

class Poison extends DamageOnTickEffect {
  Poison({
    required super.char,
    required super.target,
    super.name = 'Poison',
    super.iconPath = 'assets/poison.jpg',
    super.duration = 4,
    super.maxStack = 3
  });

  @override
  String get tooltip => 'Каждый ход наносит $damage урона';

  @override
  get damage => (char.ATK * 0.2 * stack).round();
}

class ToxicVaporAura extends Aura {
  GameObject target;
  ToxicVaporAura({
    required super.char,
    required this.target,
    super.name = 'Toxic vapor',
    super.iconPath = 'assets/toxic_vapor.jpg',
    super.duration = 3,
    super.maxStack = 1
  });

  @override
  String get tooltip => 'Накладывает Poison на противника';

  @override
  BattleEvent tick() {
    target.applyEffect(Poison(char: char, target: target));
    return super.tick();
  }
}

class PoisonBombAura extends StatModifierAura {
  PoisonBombAura({
    required super.char,
    super.modifier = const StatModifier(0.20),
    super.name = 'Poison Bomb',
    super.iconPath = 'assets/poison_bomb.jpg',
    super.duration = 4,
    super.maxStack = 1
  });

  @override
  String get tooltip => 'Получаемый урон повышен на 20%';

  @override
  void initial() {
    char.stats.physicalDamageResist.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.stats.physicalDamageResist.removeModifier(modifier);
  }
}

class ExperimentalPotionAura extends StatModifierAura {
  ExperimentalPotionAura({
    required super.char,
    super.modifier = const StatModifier(0.15, type: ModifierType.percent),
    super.name = 'Experimental Potion',
    super.iconPath = 'assets/experimental_potion.jpg',
    super.duration = 5,
    super.maxStack = 1
  });

  @override
  String get tooltip => 'Ловкость повышена на 15%';

  @override
  void initial() {
    char.stats.DEX.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.stats.DEX.removeModifier(modifier);
  }
}

class Bleed extends DamageOnTickEffect {
  Bleed({
    required super.char,
    required super.target,
    super.name = 'Bleed',
    super.iconPath = 'assets/bleed.jpg',
    super.duration = 4,
    super.maxStack = 3
  });

  @override
  String get tooltip => 'Каждый ход наносит $damage урона';

  @override
  int get damage => (char.ATK * 0.2 * stack).round();
}

class BloodFountainAura extends StatModifierAura {
  late double value;
  BloodFountainAura({
    required super.char,
    required super.modifier,
    super.name = 'Blood Fountain',
    super.iconPath = 'assets/blood_fountain.jpg',
    super.duration = 4,
    super.maxStack = 1
  });

  @override
  String get tooltip => '';

  @override
  void initial() {
    char.stats.STR.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.stats.STR.removeModifier(modifier);
  }
}

class ReapAura extends StatModifierAura {
  ReapAura({
    required super.char,
    required super.modifier,
    super.name = 'Reap',
    super.iconPath = 'assets/reap.jpg',
    super.duration = 5,
    super.maxStack = 1
  });

  @override
  String get tooltip => '';

  @override
  void initial() {
    char.stats.physicalDamageModifier.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.stats.physicalDamageModifier.removeModifier(modifier);
  }
}

class Superiority extends Aura {
  Superiority({
    required super.char,
    super.name = 'Superiority',
    super.iconPath = 'assets/superiority.jpg',
    super.duration = 99,
    super.maxStack = 1
  });

  @override
  String get tooltip => '';
}

class SwiftRushAura extends StatModifierAura {
  SwiftRushAura({
    required super.char,
    super.modifier = const StatModifier(0.15),
    super.name = 'Swift Rush',
    super.iconPath = 'assets/swift_rush.jpg',
    super.duration = 3,
    super.maxStack = 1
  });

  @override
  String get tooltip => 'Повышает крит шанс на 15%';

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
  StatModifier mod = const StatModifier(-0.01);
  BonecrusherAura({
    required super.char,
    super.modifier = const StatModifier(-0.01),
    super.name = 'Bonecrusher',
    super.iconPath = 'assets/swift_rush.jpg',
    super.duration = 99,
    super.maxStack = 15
  }) {
    mod = StatModifier(-0.01 * stack);
  }

  @override
  String get tooltip => 'Понижает получаемый урон на ${1 * stack}%';

  @override
  void initial() {
    char.stats.physicalDamageResist.addModifier(mod);
    char.stats.magicalDamageResist.addModifier(mod);
  }

  @override
  void onExpire() {
    char.stats.physicalDamageResist.removeModifier(mod);
    char.stats.magicalDamageResist.removeModifier(mod);
  }
  @override
  BattleEvent tick() {
    onExpire();
    mod = StatModifier(-0.01 * stack);
    initial();
    return super.tick();
  }
}

class EvasionAura extends StatModifierAura {
  EvasionAura({
    required super.char,
    super.modifier = const StatModifier(0.5, type: ModifierType.percent),
    super.name = 'Evasion',
    super.iconPath = 'assets/evasion.jpg',
    super.duration = 2,
    super.maxStack = 1
  });

  @override
  String get tooltip => 'Повышает шанс уклонения на 50%';

  @override
  void initial() {
    char.evasionChance.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.evasionChance.removeModifier(modifier);
  }
}

class BloodlettingAura extends StatModifierAura {
  BloodlettingAura({
    required super.char,
    super.modifier = const StatModifier(0.05),
    super.name = 'Bloodletting',
    super.iconPath = 'assets/bloodletting.jpg',
    super.duration = 99,
    super.maxStack = 1,
    super.stack = 1
  });

  @override
  String get tooltip => '';

  @override
  void initial() {
    char.stats.physicalDamageModifier.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.stats.physicalDamageModifier.removeModifier(modifier);
  }
}

// TODO: implement BattleLust
class BattleLustAura extends StatModifierAura {
  BattleLustAura({
    required super.char,
    super.modifier = const StatModifier(0.1),
    required super.name,
    required super.iconPath,
    required super.duration,
    required super.maxStack,
    required super.stack
  });

  @override
  String get tooltip => '';

  @override
  void initial() {
    // TODO: implement initial
  }

  @override
  void onExpire() {
    // TODO: implement onExpire
  }
}

class Flame extends DamageOnTickEffect {
  Flame({
    required super.char,
    required super.target,
    super.name = 'Flame',
    super.iconPath = 'assets/flame.jpg',
    super.duration = 4,
    super.maxStack = 3
  });

  @override
  String get tooltip => '';

  @override
  int get damage => (char.MATK * 0.25).round();
}

class FireBlastAura extends StatModifierAura {
  FireBlastAura({
    required super.char,
    required super.modifier,
    super.name = 'Fire Blast',
    super.iconPath = 'assets/fire_blast.jpg',
    super.duration = 3,
    super.maxStack = 3
  });

  @override
  String get tooltip => '';

  @override
  void initial() {
    char.critChance.addModifier(modifier);
  }

  @override
  void onExpire() {
    char.critChance.removeModifier(modifier);
  }
}
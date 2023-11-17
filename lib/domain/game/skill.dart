
import 'dart:math';

import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/effect.dart';
import 'package:arentale/domain/game/game_object.dart';

enum DamageType {
  physical, magical
}

Skill? getSkill(GameObject char, GameObject target, String name) {
  Map<String, Skill> skillMap = {
    'Sneaky blow': SneakyBlow(char: char, target: target),
    'Evasion': Evasion(char: char),
    'Poisoned Shot': PoisonedShot(char: char, target: target),
    'Intoxication': Intoxication(char: char, target: target),
    'Toxic Vapor': ToxicVapor(char: char, target: target),
    'Swing And Cut': SwingAndCut(char: char, target: target),
    'Swift Rush': SwiftRush(char: char),
    'Blade Strike': BladeStrike(char: char, target: target),
    'Shining Blade': ShiningBlade(char: char, target: target),
    'Guillotine': Guillotine(char: char, target: target),
    'Breakthrough': Breakthrough(char: char, target: target),
    'Bloodletting': Bloodletting(char: char),
    'bite': Bite(char: char, target: target),
    'stump': Stump(char: char, target:  target),
    'ram': Ram(char: char, target: target)
  };
  return skillMap[name];
}

int getEffectStack(String name, GameObject target) {
  int stack = 0;
  for (Effect ef in target.effects) {
    if (ef.name == name) {
      stack = ef.stack;
      break;
    }
  }
  return stack;
}

abstract class Skill {
  final GameObject char;
  final String name;
  final String? iconPath;
  final String? tooltip;

  const Skill({
    required this.char,
    required this.name,
    this.iconPath,
    this.tooltip
  });

  int get cost;

  List<BattleEvent> cast();
}

abstract class DamageSkill extends Skill {
  final GameObject target;
  final DamageType type;

  const DamageSkill({
    required super.char,
    required this.target,
    required super.name,
    super.iconPath,
    super.tooltip,
    required this.type
  });

  int get damage;
}

mixin PlayerDamage on DamageSkill {
  @override
  List<BattleEvent> cast() {
    if (cost > char.MP) {
      return [NotEnoughMana('\n🔵Недостаточно маны!', char)];
    }
    bool crit = char.isCrit();
    bool evade = target.isEvade();
    int finalDamage;
    if (type == DamageType.physical) {
      finalDamage = (damage * target.physicalResist * char.physicalModifier).round();
    } else {
      finalDamage = (damage * target.magicalResist * char.magicalModifier).round();
    }

    if (evade) {
      return [
        Attack({'damage': 0, 'cost': cost, 'message': '\n🔵$name: уклонение'}, char: char, target: target),
        OnEvade(target)
      ];
    }
    else if (crit) {
      finalDamage = (char.critDamage.finalValue * finalDamage).round();
      return [
        Attack({'damage': finalDamage, 'cost': cost, 'message': '\n🔵$name: $finalDamage крит'}, char: char, target: target),
        OnCrit(char)
      ];
    }
    else {
      return [
        Attack({'damage': finalDamage, 'cost': cost, 'message': '\n🔵$name: $finalDamage'}, char: char, target: target)
      ];
    }
  }
}

mixin MobDamage on DamageSkill {
  @override
  List<BattleEvent> cast() {
    if (cost > char.MP) {
      return [NotEnoughMana('\n🔴Недостаточно маны!', char)];
    }
    bool crit = char.isCrit();
    bool evade = target.isEvade();
    int finalDamage;

    if (type == DamageType.physical) {
      finalDamage = (damage * target.physicalResist * char.physicalModifier).round();
    } else {
      finalDamage = (damage * target.magicalResist * char.magicalModifier).round();
    }

    if (evade) {
      return [
        Attack({'damage': 0, 'cost': cost, 'message': '\n🔴$name: уклонение'}, char: char, target: target),
        OnEvade(target)
      ];
    }
    else if (crit) {
      finalDamage = (char.critDamage.finalValue * finalDamage).round();
      return [
        Attack({'damage': finalDamage, 'cost': cost, 'message': '\n🔴$name: $finalDamage крит'}, char: char, target: target),
        OnCrit(char)
      ];
    }
    else {
      return [
        Attack({'damage': finalDamage, 'cost': cost, 'message': '\n🔴$name: $finalDamage'}, char: char, target: target)
      ];
    }
  }
}

abstract class SelfAuraSkill extends Skill {
  const SelfAuraSkill({
    required super.char,
    required super.name,
    super.iconPath,
    super.tooltip
  });
}

mixin PlayerSelfAura on SelfAuraSkill {
  @override
  List<BattleEvent> cast() {
    if (cost > char.MP) {
      return [NotEnoughMana('\n🔵Недостаточно маны!', char)];
    }
    return [];
  }
}

mixin MobSelfAura on SelfAuraSkill {
  @override
  List<BattleEvent> cast() {
    if (cost > char.MP) {
      return [NotEnoughMana('\n🔴Недостаточно маны!', char)];
    }
    return [];
  }
}

abstract class EffectApply extends Skill {
  EffectApply({
    required super.char,
    required super.name,
    super.iconPath,
    super.tooltip
  });
}

mixin PlayerEffectApply on EffectApply {
  @override
  List<BattleEvent> cast() {
    if (cost > char.MP) {
      return [NotEnoughMana('\n🔵Недостаточно маны!', char)];
    }
    return [];
  }
}

mixin MobEffectApply on EffectApply {
  @override
  List<BattleEvent> cast() {
    if (cost > char.MP) {
      return [NotEnoughMana('\n🔴Недостаточно маны!', char)];
    }
    return [];
  }
}

abstract class HealingSkill extends Skill {
  HealingSkill({
    required super.char,
    required super.name,
    super.iconPath,
    super.tooltip
  });
  int get healing;

  @override
  List<BattleEvent> cast() {
    char.takeDamage(-healing);
    return [];
  }
}

//Рога

class SneakyBlow extends DamageSkill with PlayerDamage {
  const SneakyBlow({
    required super.char,
    required super.target,
    super.name = 'Sneaky Blow',
    super.iconPath = 'assets/sneaky_blow.jpg',
    super.tooltip = 'Test message',
    super.type = DamageType.physical
  });

  @override
  int get damage => (char.ATK * 0.55).round();
  @override
  int get cost => (7 + char.baseMP * 0.1).round();
}

class PoisonedShot extends DamageSkill with PlayerDamage {
  const PoisonedShot({
    required super.char,
    required super.target,
    super.name = 'Poisoned Shot',
    super.iconPath = 'assets/poisoned_shot.jpg',
    super.tooltip = 'Test message',
    super.type = DamageType.physical
  });

  @override
  int get damage => (char.ATK * 0.35).round();
  @override
  int get cost => (5 + char.baseMP * 0.1).round();

  @override
  List<BattleEvent> cast() {
    target.applyEffect(Poison(char: char, target: target));
    return super.cast();
  }
}

class Intoxication extends DamageSkill with PlayerDamage {
  const Intoxication({
    required super.char,
    required super.target,
    super.name = 'Intoxication',
    super.iconPath = 'assets/intoxication.jpg',
    super.tooltip = 'Test message',
    super.type = DamageType.physical
  });

  @override
  int get damage => (char.ATK * 0.5 * getEffectStack('poison', target)).round();
  @override
  int get cost => (15 + char.baseMP * 0.2).round();
}

class ToxicVapor extends SelfAuraSkill with PlayerSelfAura {
  final GameObject target;
  const ToxicVapor({
    required super.char,
    required this.target,
    super.name = 'Toxic Vapor',
    super.iconPath = 'assets/toxic_vapor.jpg',
    super.tooltip = 'Test message',
  });

  @override
  int get cost => (20 + char.baseMP * 0.15).round();

  @override
  List<BattleEvent> cast() {
    char.applyEffect(ToxicVaporAura(char: char, target: target));
    return super.cast();
  }
}

class PoisonBomb extends EffectApply with PlayerEffectApply {
  PoisonBomb({
    required super.char,
    super.name = 'Poison Bomb',
    super.iconPath = '', //TODO: add poison bomb icon
    super.tooltip = ''
  });

  @override
  int get cost => (20 + char.baseMP * 0.25).round();
}

class ExperimentalPotion extends HealingSkill {
  ExperimentalPotion({
    required super.char,
    required super.name,
    super.iconPath = 'assets/experimental_potion.jpg',
    super.tooltip = ''
  });

  @override
  int get cost => (25 + char.baseMP * 0.15).round();

  @override
  int get healing {
    int baseHealing = ((char.maxHP - char.HP) * 0.2).round();
    if (baseHealing < char.maxHP * 0.1) {
      char.applyEffect(ExperimentalPotionAura(char: char));
    }
    return baseHealing;
  }
}

class Wound extends DamageSkill with PlayerDamage {
  Wound({
    required super.char,
    required super.target,
    super.name = 'Wound',
    super.type = DamageType.physical,
    super.iconPath = '', //TODO: add wound icon
    super.tooltip = ''
  });

  @override
  int get cost => (15 + char.baseMP * 0.1).round();

  @override
  int get damage => (char.ATK * 0.45).round();

  @override
  List<BattleEvent> cast() {
    target.applyEffect(Bleed(char: char, target: target));
    return super.cast();
  }
}

class BloodFountain extends SelfAuraSkill with PlayerSelfAura {
  BloodFountain({required super.char, required super.name});

  @override
  // TODO: implement cost
  int get cost => throw UnimplementedError();
}

class Evasion extends SelfAuraSkill with PlayerSelfAura {
  const Evasion({
    required super.char,
    super.name = 'Evasion',
    super.iconPath = 'assets/evasion.jpg',
    super.tooltip = '',
  });

  @override
  int get cost => 0;
}

// Воин

class SwingAndCut extends DamageSkill with PlayerDamage {
  const SwingAndCut({
    required super.char,
    required super.target,
    super.iconPath = 'assets/swing_and_cut.jpg',
    super.tooltip = 'Test tooltip',
    super.name = 'Swing And Cut',
    super.type = DamageType.physical
  });

  @override
  int get damage => (char.ATK * 0.45).round();
  @override
  int get cost => (char.baseMP * 0.1).round();
}

class SwiftRush extends SelfAuraSkill with PlayerSelfAura {
  const SwiftRush({
    required super.char,
    super.name = 'Swift Rush',
    super.iconPath = 'assets/swift_rush.jpg',
    super.tooltip = ''
  });

  @override
  int get cost => (15 + char.baseMP * 0.10).round();

  @override
  List<BattleEvent> cast() {
    char.applyEffect(SwiftRushAura(char: char));
    return super.cast();
  }
}

class BladeStrike extends DamageSkill with PlayerDamage {
  const BladeStrike({
    required super.char,
    required super.target,
    super.name = 'Blade Strike',
    super.iconPath = 'assets/blade_strike.jpg',
    super.type = DamageType.physical
  });

  @override
  int get cost => (5 + char.baseMP * 0.07).round();

  @override
  int get damage => (char.ATK * 0.3).round();

  @override
  List<BattleEvent> cast() {
    if (Random().nextDouble() < 0.25) {
      char.applyEffect(Superiority(char: char));
    }
    return super.cast();
  }
}

class ShiningBlade extends DamageSkill with PlayerDamage {
  const ShiningBlade({
    required super.char,
    required super.target,
    super.name = 'Shining Blade',
    super.type = DamageType.physical,
    super.iconPath = 'assets/shining_blade.jpg',
    super.tooltip = ''
  });

  @override
  int get cost => (10 + char.baseMP * 0.2).round();

  @override
  int get damage => (char.ATK * 0.05).round();

  @override
  List<BattleEvent> cast() {
    List<BattleEvent> f = [];
    f.addAll([...super.cast(), ...super.cast(), ...super.cast(), ...super.cast(), ...super.cast(), ...super.cast()]);
    return f;
  }
}

class Guillotine extends DamageSkill with PlayerDamage {
  const Guillotine({
    required super.char,
    required super.target,
    super.name = 'Guillotine',
    // TODO add guillotine icon
    super.iconPath = 'assets/toxic_vapor.jpg',
    super.type = DamageType.physical
  });

  @override
  int get cost => (7 + char.baseMP * 0.20).round();

  @override
  int get damage {
    bool hasEffect = false;
    Effect? curEffect;
    final baseDamage = char.ATK * 0.25;
    for (var element in char.effects) {
      if (element is Superiority) {
        hasEffect = true;
        curEffect = element;
        char.effects.remove(curEffect);
        break;
      }
    }
    if (hasEffect && curEffect != null) {
      char.effects.remove(curEffect);
      return (baseDamage * char.critDamage.finalValue).round();
    }
    return baseDamage.round();
  }
}

class Breakthrough extends DamageSkill with PlayerDamage {
  const Breakthrough({
    required super.char,
    required super.target,
    super.name = 'Breakthrough',
    super.type = DamageType.physical,
    super.iconPath = 'assets/breakthrough.jpg',
    super.tooltip = ''
  });

  @override
  int get cost => (5 + char.baseMP * 0.1).round();

  @override
  int get damage {
    num finalDamage = char.ATK * 0.3;
    if (char.HP < char.maxHP * 0.7) {
      finalDamage = char.ATK * (char.maxHP / char.HP);
    }
    return finalDamage.round();
  }

}

class Bloodletting extends SelfAuraSkill with PlayerSelfAura {
  Bloodletting({
    required super.char,
    super.name = 'Bloodletting',
    super.iconPath = 'assets/bloodletting.jpg',
    super.tooltip = ''
  });

  @override
  int get cost => (15 + char.baseMP * 0.05).round();

  @override
  List<BattleEvent> cast() {
    char.takeDamage((char.maxHP * 0.1).round());
    return super.cast();
  }
}

class Execution extends DamageSkill with PlayerDamage {
  Execution({
    required super.char,
    required super.target,
    super.name = 'Execution',
    super.type = DamageType.physical,
    super.iconPath = 'assets/execution.jpg',
    super.tooltip = ''
  });

  @override
  int get cost => 0;

  @override
  int get damage {
    int baseDamage = 0;
    if (target.HP <= target.maxHP * 0.25) {
      baseDamage = (char.ATK * 0.75).round();
    }
    return baseDamage;
  }
}
// Мобы

class Bite extends DamageSkill with MobDamage {
  const Bite({
    required super.char,
    required super.target,
    super.name = 'Bite',
    super.type = DamageType.physical
  });

  @override
  int get damage => (char.ATK * 0.8).round();
  @override
  int get cost => (1 + char.baseMP * 0.05).round();
}

class Stump extends DamageSkill with MobDamage {
  const Stump({
    required super.char,
    required super.target,
    super.name = 'Stump',
    super.type = DamageType.physical
  });

  @override
  int get damage => (char.ATK * 0.9).round();
  @override
  int get cost => (1 + char.baseMP * 0.05).round();
}

class Ram extends DamageSkill with MobDamage {
  const Ram({
    required super.char,
    required super.target,
    super.name = 'Ram',
    super.type = DamageType.physical
  });

  @override
  int get damage => (char.ATK * 1.5).round();
  @override
  int get cost => (5 + char.baseMP * 0.05).round();
}

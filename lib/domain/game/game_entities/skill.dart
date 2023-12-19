
import 'dart:math';

import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/game_entities/effect.dart';
import 'package:arentale/domain/game/game_entities/game_object.dart';
import 'package:arentale/domain/game/game_entities/stat_modifier.dart';

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
    'Poison Bomb': PoisonBomb(char: char, target: target),
    'Experimental Potion': ExperimentalPotion(char: char),
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

Skill? getSkillWithoutTarget(GameObject char, String name) {
  return getSkill(char, BlankGameObject(), name);
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

  const Skill({
    required this.char,
    required this.name,
    this.iconPath
  });

  String get tooltip;

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
    required this.type
  });

  @override
  String get tooltip;

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
    super.iconPath
  });

  @override
  String get tooltip;
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
    super.iconPath
  });
  @override
  String get tooltip;
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
    super.iconPath
  });
  @override
  String get tooltip;

  int get healing;

  @override
  List<BattleEvent> cast() {
    char.takeDamage(-healing);
    return [];
  }
}

abstract class SpecialSkill extends Skill {
  SpecialSkill({
    required super.char,
    required super.name,
    super.iconPath
  });

  @override
  String get tooltip;

  @override
  List<BattleEvent> cast({List<BattleEvent> events = const []}) {
    if (cost > char.MP) {
      return [NotEnoughMana('\n🔴Недостаточно маны!', char)];
    }
    return events;
  }
}

//Рога

class SneakyBlow extends DamageSkill with PlayerDamage {
  const SneakyBlow({
    required super.char,
    required super.target,
    super.name = 'Подлый удар',
    super.iconPath = 'assets/sneaky_blow.jpg',
    super.type = DamageType.physical
  });

  @override
  String get tooltip => 'Подлый удар\nНаносит $damage физического урона\nПотребляет $cost маны';

  @override
  int get damage => (char.ATK * 0.55).round();
  @override
  int get cost => (7 + char.baseMP * 0.1).round();
}

class PoisonedShot extends DamageSkill with PlayerDamage {
  const PoisonedShot({
    required super.char,
    required super.target,
    super.name = 'Отравляющий укол',
    super.iconPath = 'assets/poisoned_shot.jpg',
    super.type = DamageType.physical
  });

  @override
  String get tooltip => 'Отравляющий укол\nНаносит $damage физического урона и накладывает Яд\nПотребляет $cost маны';

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
    super.name = 'Интоксикация',
    super.iconPath = 'assets/intoxication.jpg',
    super.type = DamageType.physical
  });

  @override
  String get tooltip => 'Интоксикация\nНаносит $damage физического урона\nПотребляет $cost маны';

  @override
  int get damage => (char.ATK * 0.5 * getEffectStack('Poison', target)).round();
  @override
  int get cost => (15 + char.baseMP * 0.2).round();
}

class ToxicVapor extends SelfAuraSkill with PlayerSelfAura {
  final GameObject target;
  const ToxicVapor({
    required super.char,
    required this.target,
    super.name = 'Токсичные испарения',
    super.iconPath = 'assets/toxic_vapor.jpg',
  });

  @override
  String get tooltip => 'Токсичные испарения\nВ течении 3 ходов накладывает на противника Яд\nПотребляет $cost маны';

  @override
  int get cost => (20 + char.baseMP * 0.15).round();

  @override
  List<BattleEvent> cast() {
    char.applyEffect(ToxicVaporAura(char: char, target: target));
    return super.cast();
  }
}

class PoisonBomb extends EffectApply with PlayerEffectApply {
  final GameObject target;
  PoisonBomb({
    required super.char,
    required this.target,
    super.name = 'Ядовитая бомба',
    super.iconPath = 'assets/poison_bomb.jpg',
  });

  @override
  String get tooltip => 'Ядовитая бомба\nПовышает урон, получаемый целью на 20% на 4 хода\nПотребляет $cost маны';

  @override
  int get cost => (20 + char.baseMP * 0.25).round();

  @override
  List<BattleEvent> cast() {
    target.applyEffect(PoisonBombAura(char: target));
    return super.cast();
  }
}

class ExperimentalPotion extends HealingSkill {
  ExperimentalPotion({
    required super.char,
    super.name = 'Экспериментальное зелье',
    super.iconPath = 'assets/experimental_potion.jpg'
  });

  @override
  String get tooltip => 'Experimental Potion\n'
      'Восстанавливает 20% от недостающего здоровья. Если восстанавливает менее 10% от максимального здоровья, повышает ловкость на 15% на 5 ходов.'
      '\nПотребляет $cost маны';

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
    super.name = 'Рана',
    super.type = DamageType.physical,
    super.iconPath = 'assets/wound.jpg',
  });

  @override
  String get tooltip => 'Рана\nНаносит $damage физического урона и накладывает Кровотечение\nПотребляет $cost маны';

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
  final GameObject target;
  BloodFountain({
    required super.char,
    required this.target,
    super.name = 'Кровавый фонтан',
    super.iconPath = 'assets/blood_fountain.jpg',
  });

  @override
  String get tooltip => 'Кровавый фонтан\nУвиличивает силу на 5% за каждый заряд Кровотечения на противнике на 4 хода\nПотребляет $cost маны';

  @override
  int get cost => (20 + char.baseMP * 0.1).round();
  
  @override
  List<BattleEvent> cast() {
    char.applyEffect(BloodFountainAura(char: char, modifier: StatModifier(0.05 * getEffectStack('Blood Fountain', target), type: ModifierType.percent)));
    return super.cast();
  }
}

class Gutting extends DamageSkill with PlayerDamage {
  Gutting({
    required super.char,
    required super.target,
    super.name = 'Потрошение',
    super.type = DamageType.physical,
    super.iconPath = 'assets/gutting.jpg'
  });

  @override
  String get tooltip => 'Потрошение\nНаносит $damage физического урона, если у цели меньше 50% здоровья, накладывает 2 заряда Кровотечения\nПотребляет $cost маны';

  @override
  int get cost => (5 + char.baseMP * 0.17).round();

  @override
  int get damage => (char.ATK * 0.35).round();

  @override
  List<BattleEvent> cast() {
    if (target.HP < target.maxHP / 2) {
      target.applyEffect(Bleed(char: char, target: target));
      target.applyEffect(Bleed(char: char, target: target));
    }
    return super.cast();
  }
}

class Vendetta extends SpecialSkill {
  Vendetta({
    required super.char,
    super.name = 'Вендетта',
    super.iconPath = 'assets/experimental_potion.jpg', //TODO: add Vendetta icon
  });

  @override
  String get tooltip => 'Вендетта\nЕсли вы находитесь под действием Кровавого фонтана, восстанавливает 20% маны';

  @override
  int get cost => 0;

  @override
  List<BattleEvent> cast({List<BattleEvent> events = const []}) {
    if (getEffectStack('Blood Fountain', char) != 0) {
      char.consumeMP(-(char.maxMP * 0.2).round());
    }
    return super.cast();
  }
}

class Reap extends EffectApply with PlayerEffectApply {
  final GameObject target;
  Reap({
    required super.char,
    required this.target,
    super.name = 'Жатва',
    super.iconPath = 'assets/reap.jpg',
  });

  @override
  String get tooltip => 'Жатва\nУменьшает наносимый противником урон на 7% за каждый заряд Кровотечения на 5 ходов\nПотребляет $cost маны';

  @override
  int get cost => (10 + char.baseMP * 0.2).round();

  @override
  List<BattleEvent> cast() {
    target.applyEffect(ReapAura(char: target, modifier: StatModifier(-(0.07 * getEffectStack('Bleed', target)))));
    return super.cast();
  }
}

class Evasion extends SelfAuraSkill with PlayerSelfAura {
  const Evasion({
    required super.char,
    super.name = 'Ускользание',
    super.iconPath = 'assets/evasion.jpg'
  });

  @override
  String get tooltip => 'Ускользание\nПовышает вероятность уклонения на 50%\nПотребляет $cost маны';

  @override
  int get cost => (10 + char.baseMP * 0.2).round();

  @override
  List<BattleEvent> cast() {
    char.applyEffect(EvasionAura(char: char));
    return super.cast();
  }
}

// Воин

class SwingAndCut extends DamageSkill with PlayerDamage {
  const SwingAndCut({
    required super.char,
    required super.target,
    super.iconPath = 'assets/swing_and_cut.jpg',
    super.name = 'Swing And Cut',
    super.type = DamageType.physical
  });

  @override
  String get tooltip => '$name\nНаносит $damage физического урона\nПотребляет $cost маны';

  @override
  int get damage => (char.ATK * 0.45).round();
  @override
  int get cost => (char.baseMP * 0.1).round();
}

class SwiftRush extends SelfAuraSkill with PlayerSelfAura {
  const SwiftRush({
    required super.char,
    super.name = 'Стремительный прорыв',
    super.iconPath = 'assets/swift_rush.jpg',
  });

  @override
  String get tooltip => '$name\nПовышает крит шанс на 15%\nПотребляет $cost маны';

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
    super.name = 'Удар клинка',
    super.iconPath = 'assets/blade_strike.jpg',
    super.type = DamageType.physical
  });

  @override
  String get tooltip => '$name\nНаносит $damage физического урона. С шансом 25% накладывает эффект Превосходство\nПотребляет $cost маны';

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
    super.iconPath = 'assets/shining_blade.jpg'
  });

  @override
  String get tooltip => '$name\nНаносит $damage физического урона пять раз\nПотребляет $cost маны';

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
    super.iconPath = 'assets/guillotine.jpg',
    super.type = DamageType.physical
  });

  @override
  String get tooltip => '$name\nНаносит $damage физического урона\nПотребляет $cost маны';

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
  });

  @override
  String get tooltip => '$name\nНаносит $damage физического урона\nПотребляет $cost маны';

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
  });

  @override
  String get tooltip => '$name\nОтнимает 10% здоровья и повышает наносимый урон на 5%(не складывается)\nПотребляет $cost маны';

  @override
  int get cost => (15 + char.baseMP * 0.05).round();

  @override
  List<BattleEvent> cast() {
    char.takeDamage((char.maxHP * 0.1).round());
    char.applyEffect(BloodlettingAura(char: char));
    return super.cast();
  }
}

class Execution extends DamageSkill with PlayerDamage {
  Execution({
    required super.char,
    required super.target,
    super.name = 'Execution',
    super.type = DamageType.physical,
    super.iconPath = 'assets/execution.jpg'
  });

  @override
  String get tooltip => '$name\nНаносит $damage физического урона\nПотребляет $cost маны';

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

// Маг

class Fireball extends DamageSkill with PlayerDamage {
  const Fireball({
    required super.char,
    required super.target,
    super.name = 'Fireball',
    super.type = DamageType.magical,
    super.iconPath = 'assets/fireball.jpg'
  });

  @override
  String get tooltip => '$name\nНаносит $damage магического урона и накладывает Горение\nПотребляет $cost маны';

  @override
  int get cost => (10 + char.baseMP * 0.15).round();

  @override
  int get damage => (char.MATK * 0.45).round();

  @override
  List<BattleEvent> cast() {
    target.applyEffect(Flame(char: char, target: target));
    return super.cast();
  }
}

class FireBlast extends DamageSkill with PlayerDamage {
  const FireBlast({
    required super.char,
    required super.target,
    super.name = 'Fire Blast',
    super.type = DamageType.magical,
    super.iconPath = 'assets/fire_blast.jpg'
  });

  @override
  String get tooltip => '$name\nНаносит $damage физического урона\nПотребляет $cost маны';

  @override
  int get cost => (30 + char.baseMP * 0.15).round();

  @override
  int get damage => (char.MATK * 0.25 * getEffectStack('Flame', target)).round();

  @override
  List<BattleEvent> cast() {
    char.applyEffect(FireBlastAura(char: char, modifier: StatModifier(0.03 * getEffectStack('Flame', target))));
    return super.cast();
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
  String get tooltip => '$name\nНаносит $damage физического урона\nПотребляет $cost маны';

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
  String get tooltip => '$name\nНаносит $damage физического урона\nПотребляет $cost маны';

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
  String get tooltip => '$name\nНаносит $damage физического урона\nПотребляет $cost маны';

  @override
  int get damage => (char.ATK * 1.5).round();
  @override
  int get cost => (5 + char.baseMP * 0.05).round();
}

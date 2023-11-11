
import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/effect.dart';
import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/game/player/player.dart';

Skill? getSkill(GameObject char, GameObject target, String name) {
  Map<String, Skill> skillMap = {
    'Sneaky blow': SneakyBlow(char: char, target: target),
    'Evasion': Evasion(char: char, target: target),
    'Poisoned Shot': PoisonedShot(char: char, target: target),
    'Swing And Cut': SwingAndCut(char: char, target: target),
    'bite': Bite(char: char, target: target),
    'stump': Stump(char: char, target:  target),
    'ram': Ram(char: char, target: target)
  };
  return skillMap[name];
}

abstract class Skill {
  GameObject char;
  GameObject target;
  String name;
  String iconPath;
  String type;
  String tooltip;
  late int damage;
  late int cost;

  Skill({
    required this.char,
    required this.target,
    required this.name,
    required this.iconPath,
    required this.tooltip,
    required this.type
  });

  List<BattleEvent> cast() {
    if(char.runtimeType == Player) {
      if(char.MP >= cost) {
        num crit = char.crit();
        num evade = target.evade();

        if (evade == 0) {
          return [
            Attack(
              {'damage': 0, 'cost': cost, 'message': '\n🔵$name: уклонение'},
              char: char,
              target: target
            ),
            OnEvade(target)
          ];
        }
        if (crit > 1) {
          return [
            Attack(
              {'damage': damage, 'cost': cost, 'message': '\n🔵$name: $damage крит'},
                char: char,
                target: target
            ),
            OnCrit(char)
          ];
        }
        return [
          Attack(
            {'damage': damage, 'cost': cost, 'message': '\n🔵$name: $damage'},
              char: char,
              target: target
          )
        ];
      } else {
        return [
          NotEnoughMana('\nНедостаточно маны!', char)
        ];
      }
    } else {
      if(target.MP >= cost) {
        num crit = target.crit();
        num evade = char.evade();

        if (evade == 0) {
          return [
            Attack(
                {'damage': 0, 'cost': cost, 'message': '\n🔴$name: уклонение'},
                char: char,
                target: target
            ),
            OnEvade(char)
          ];
        }
        if (crit > 1) {
          return [
            Attack(
                {'damage': damage, 'cost': cost, 'message': '\n🔴$name: $damage крит'},
                char: char,
                target: target
            ),
            OnCrit(target)
          ];
        }
        return [
          Attack(
              {'damage': damage, 'cost': cost, 'message': '\n🔴$name: $damage'},
              char: char,
              target: target
          )
        ];
      }
    }
    return [];
  }
}

class SneakyBlow extends Skill {
  SneakyBlow({
    required super.char,
    required super.target,
    super.name = 'Sneaky Blow',
    super.iconPath = 'assets/sneaky_blow.jpg',
    super.tooltip = 'Test message',
    super.type = 'Phys'
  });

  @override
  int get damage => (char.ATK * 0.55).round();
  @override
  int get cost => (7 + char.baseMP * 0.1).round();
}

class PoisonedShot extends Skill {
  PoisonedShot({
    required super.char,
    required super.target,
    super.name = 'Poisoned Shot',
    super.iconPath = 'assets/poisoned_shot.jpg',
    super.tooltip = 'Test message',
    super.type = 'Phys'
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

class Intoxication extends Skill {
  Intoxication({
    required super.char,
    required super.target,
    super.name = 'Intoxication',
    super.iconPath = 'assets/intoxication.jpg',
    super.tooltip = 'Test message',
    super.type = 'Phys'
  });

  @override
  int get damage => (char.ATK * 0.5 * getEffectStack('poison', target)).round();
  @override
  int get cost => (15 + char.baseMP * 0.2).round();
}

class ToxicVapor extends Skill {
  ToxicVapor({
    required super.char,
    required super.target,
    super.name = 'Toxic Vapor',
    super.iconPath = 'assets/toxic_vapor.jpg',
    super.tooltip = 'Test message',
    super.type = 'Phys'
  });

  @override
  int get damage => 0;
  @override
  int get cost => (20 + char.baseMP * 0.15).round();

  @override
  List<BattleEvent> cast() {
    char.applyEffect(ToxicVaporAura(char: char, target: target));
    return super.cast();
  }
}

class Evasion extends Skill {
  Evasion({
    required super.char,
    required super.target,
    super.name = '',
    super.iconPath = 'assets/evasion.jpg',
    super.tooltip = '',
    super.type = ''
  });
  @override
  int get damage => 0;
  @override
  int get cost => 0;
}

class SwingAndCut extends Skill {
  SwingAndCut({
    required super.char,
    required super.target,
    super.iconPath = 'assets/swing_and_cut.jpg',
    super.tooltip = 'Test tooltip',
    super.name = 'Swing And Cut',
    super.type = 'phys'
  });

  @override
  int get damage => (char.ATK * 0.45).round();
  @override
  int get cost => (char.baseMP * 0.1).round();
}

class Bite extends Skill {
  Bite({
    required super.char,
    required super.target,
    super.iconPath = '',
    super.tooltip = '',
    super.name = 'Bite',
    super.type = 'phys'
  });

  @override
  int get damage => (char.ATK * 0.8).round();
  @override
  int get cost => (1 + char.baseMP * 0.05).round();
}

class Stump extends Skill {
  Stump({
    required super.char,
    required super.target,
    super.iconPath = '',
    super.tooltip = '',
    super.name = 'Stump',
    super.type = 'phys'
  });

  @override
  int get damage => (char.ATK * 0.9).round();
  @override
  int get cost => (1 + char.baseMP * 0.05).round();
}

class Ram extends Skill {
  Ram({
    required super.char,
    required super.target,
    super.iconPath = '',
    super.tooltip = '',
    super.name = 'Ram',
    super.type = 'phys'
  });

  @override
  int get damage => (char.ATK * 1.5).round();
  @override
  int get cost => (5 + char.baseMP * 0.05).round();
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
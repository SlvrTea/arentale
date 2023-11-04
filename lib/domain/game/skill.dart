
import 'package:arentale/domain/game/battle/battle_event.dart';
import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/game/player/player.dart';

Skill? getSkill(GameObject player, GameObject target, String name) {
  Map<String, Skill> skillMap = {
    'Sneaky blow': SneakyBlow(char: player, target: target),
    'Evasion': Evasion(char: player, target: target),
    'bite': Bite(char: player,target: target)
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
              char,
              target
            ),
            OnEvade(target)
          ];
        }
        if (crit > 1) {
          return [
            Attack(
              {'damage': damage, 'cost': cost, 'message': '\n🔵$name: $damage крит'},
              char,
              target
            ),
            OnCrit(char)
          ];
        }
        return [
          Attack(
            {'damage': damage, 'cost': cost, 'message': '\n🔵$name: $damage'},
            char,
            target
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
                target,
                char
            ),
            OnEvade(char)
          ];
        }
        if (crit > 1) {
          return [
            Attack(
                {'damage': damage, 'cost': cost, 'message': '\n🔴$name: $damage крит'},
                target,
                char
            ),
            OnCrit(target)
          ];
        }
        return [
          Attack(
              {'damage': damage, 'cost': cost, 'message': '\n🔴$name: $damage'},
              target,
              char
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
  int get cost => (7 + char.maxMP * 0.1).round();
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
  int get damage => (char.ATK * 0.7).round();
  @override
  int get cost => (1+ char.maxHP * 0.05).round();
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
}

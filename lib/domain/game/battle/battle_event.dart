
import '../game_entities/game_object.dart';

abstract class BattleEvent {
  final GameObject? char;
  final GameObject? target;

  const BattleEvent({this.char, this.target});
  String ef();
}

class Attack extends BattleEvent {
  final Map<String, dynamic> result;
  @override
  final GameObject char;
  @override
  final GameObject target;

  const Attack(this.result, {required this.char, required this.target});

  @override
  String ef() {
    char.consumeMP(result['cost']);
    target.takeDamage(result['damage']);
    return result['message'];
  }
}

class DamageTick extends BattleEvent {
  final Map<String, dynamic> result;
  @override
  final GameObject target;

  DamageTick(this.result, this.target);

  @override
  String ef() {
    target.takeDamage(result['damage']);
    return result['message'];
  }
}

class AuraTick extends BattleEvent {
  @override
  String ef() {
    return '';
  }
}

class OnCrit extends BattleEvent {
  @override
  final GameObject char;

  OnCrit(this.char);

  @override
  String ef() {
    return '';
  }
}

class OnEvade extends BattleEvent {
  @override
  GameObject char;

  OnEvade(this.char);

  @override
  String ef() {
    return '';
  }
}

class OnTakeDamage extends BattleEvent {
  @override
  String ef() {
    // TODO: implement ef
    throw UnimplementedError();
  }
}

class OnDealDamage extends BattleEvent {
  @override
  String ef() {
    // TODO: implement ef
    throw UnimplementedError();
  }
}

class NotEnoughMana extends BattleEvent {
  String result;
  @override
  GameObject char;

  NotEnoughMana(this.result, this.char);

  @override
  String ef() {
    char.consumeMP(-(char.maxHP * char.INT * 0.3).toInt());
    return result;
  }
}
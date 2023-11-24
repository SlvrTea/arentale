
import '../game_object.dart';

abstract class BattleEvent {

  String ef();
}

class Attack implements BattleEvent {
  Map<String, dynamic> result;
  GameObject char;
  GameObject target;

  Attack(this.result, {required this.char, required this.target});

  @override
  String ef() {
    char.consumeMP(result['cost']);
    target.takeDamage(result['damage']);
    return result['message'];
  }
}

class DamageTick implements BattleEvent {
  Map<String, dynamic> result;
  GameObject target;

  DamageTick(this.result, this.target);

  @override
  String ef() {
    target.takeDamage(result['damage']);
    return result['message'];
  }
}

class AuraTick implements BattleEvent {
  @override
  String ef() {
    return '';
  }
}

class OnCrit implements BattleEvent {
  GameObject char;

  OnCrit(this.char);

  @override
  String ef() {
    return '';
  }
}

class OnEvade implements BattleEvent {
  GameObject char;

  OnEvade(this.char);

  @override
  String ef() {
    return '';
  }
}

class OnTakeDamage implements BattleEvent {
  @override
  String ef() {
    // TODO: implement ef
    throw UnimplementedError();
  }
}

class OnDealDamage implements BattleEvent {
  @override
  String ef() {
    // TODO: implement ef
    throw UnimplementedError();
  }
}

class NotEnoughMana implements BattleEvent {
  String result;
  GameObject char;

  NotEnoughMana(this.result, this.char);

  @override
  String ef() {
    char.consumeMP(-(char.maxHP * char.INT * 0.3).toInt());
    return result;
  }
}
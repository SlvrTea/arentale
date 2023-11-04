
import '../game_object.dart';

abstract class BattleEvent {

  String ef();
}

class Attack extends BattleEvent {
  Map<String, dynamic> result;
  GameObject char;
  GameObject target;

  Attack(this.result, this.char, this.target);

  @override
  String ef() {
    char.consumeMP(result['cost']);
    target.takeDamage(result['damage']);
    return result['message'];
  }
}

class DamageTick extends BattleEvent {
  @override
  String ef() {
    // TODO: implement ef
    throw UnimplementedError();
  }
}

class AuraTick extends BattleEvent {
  @override
  String ef() {
    // TODO: implement ef
    throw UnimplementedError();
  }
}

class OnCrit extends BattleEvent {
  GameObject char;

  OnCrit(this.char);

  @override
  String ef() {
    // TODO: implement ef
    throw UnimplementedError();
  }
}

class OnEvade extends BattleEvent {
  GameObject char;

  OnEvade(this.char);

  @override
  String ef() {
    // TODO: implement ef
    throw UnimplementedError();
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
  GameObject char;

  NotEnoughMana(this.result, this.char);

  @override
  String ef() {
    char.consumeMP(-(char.maxHP * char.INT * 0.3).toInt());
    return result;
  }
}
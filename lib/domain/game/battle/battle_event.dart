
abstract class BattleEvent {}

class PlayerAttack extends BattleEvent {}

class DamageTick extends BattleEvent {}

class AuraTick extends BattleEvent {}

class OnCrit extends BattleEvent {}

class OnEvade extends BattleEvent {}

class OnTakeDamage extends BattleEvent {}

class OnDealDamage extends BattleEvent {}
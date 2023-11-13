import 'package:arentale/domain/game/stat_modifier.dart';

class Stat {
  final num baseValue;
  num get finalValue => _getFinalValue();
  List<StatModifier> modifiers = [];

  Stat(this.baseValue);

  void addModifier(StatModifier modifier) {
    modifiers.add(modifier);
  }

  void removeModifier(StatModifier modifier) {
    modifiers.remove(modifier);
  }

  num _getFinalValue() {
    num value = baseValue;
    if(modifiers.isNotEmpty) {
      for(StatModifier modifier in modifiers) {
        if(modifier.type == ModifierType.flat) {
          value += modifier.value;
        }
      }
      for(StatModifier modifier in modifiers) {
        if(modifier.type == ModifierType.percent) {
          value += (modifier.value * baseValue).round();
        }
      }
    }
    return value;
  }
}
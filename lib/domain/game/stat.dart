import 'package:arentale/domain/game/stat_modifier.dart';

class Stat {
  final int baseValue;
  int get finalValue => _getFinalValue();
  List<StatModifier> modifiers = [];

  Stat(this.baseValue);

  void addModifier(StatModifier modifier) {
    modifiers.add(modifier);
  }

  void removeModifier(StatModifier modifier) {
    modifiers.remove(modifier);
  }

  int _getFinalValue() {
    int value = baseValue;
    if(modifiers.isNotEmpty) {
      for(StatModifier modifier in modifiers) {
        if(modifier.type == 'flat') {
          value += modifier.value;
        }
      }
      for(StatModifier modifier in modifiers) {
        if(modifier.type == 'percent') {
          value *= modifier.value;
        }
      }
    }
    return value;
  }
}
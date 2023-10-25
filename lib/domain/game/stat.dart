import 'package:arentale/domain/game/stat_modifier.dart';

class Stat {
  int baseValue = 0;
  int finalValue = 0;
  final List<StatModifier> modifiers = [];

  Stat(int value) {
    baseValue = value;
    finalValue = value;
  }

  void addModifier(StatModifier modifier) {
    modifiers.add(modifier);
    finalValue = baseValue;
    setFinalValue();
  }

  void removeModifier(StatModifier modifier) {
    modifiers.remove(modifier);
    finalValue = baseValue;
    setFinalValue();
  }

  void setFinalValue() {
    if(modifiers.isNotEmpty) {
      for(StatModifier modifier in modifiers) {
        if(modifier.type == 'flat') {
          finalValue += modifier.value;
        }
      }
      for(StatModifier modifier in modifiers) {
        if(modifier.type == 'percent') {
          finalValue *= modifier.value;
        }
      }
    }
  }
}

enum ModifierType {
  flat, percent
}

class StatModifier{
  final ModifierType type;
  final num value;

  const StatModifier(this.value, {this.type = ModifierType.flat});
}
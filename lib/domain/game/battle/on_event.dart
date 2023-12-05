
import 'package:arentale/domain/game/game_entities/effect.dart';
import 'package:arentale/domain/game/game_entities/game_object.dart';

abstract class OnEvent {
  final GameObject char;
  const OnEvent({
    required this.char
  });

  void e();
}

class Bonecrusher extends OnEvent {
  const Bonecrusher({required super.char});

  @override
  void e() {
    char.applyEffect(BonecrusherAura(char: char));
  }
}
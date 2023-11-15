
import 'dart:math';

import 'package:arentale/domain/game/battle/battle_loop.dart';
import 'package:arentale/domain/game/game_object.dart';
import 'package:arentale/domain/game/skill.dart';
import 'package:arentale/domain/player_model.dart';

import '../player/player.dart';

class BattleController {
  final Player player;
  final PlayerModel playerModel;
  final GameObject mob;
  final BattleLoop loop = BattleLoop();
  String log = '';
  bool isBattle = true;

  BattleController(this.player, this.mob, this.playerModel);

  void battleEnd() {
    isBattle = false;
    if (mob.HP <= 0) {
      final drop = mob.getDrop();
      final int exp = (mob.info['exp'] + Random().nextInt((mob.info['exp'] / 2).round()));
      final int gold = (mob.info['gold'] + Random().nextInt((mob.info['exp'] / 2).round()));
      playerModel.addGold(gold);
      playerModel.addExp(exp);
      log += '\nПолучено: $exp опыта';
      log += '\nПолучено: $gold золота';
      if (drop.isNotEmpty) {
        playerModel.addItems(drop);
        log += '\nПолучено: $drop';
      }
      log += '\nВы победили!';
    } else if (player.HP <= 0) {
      log += '\nВы проиграли!';
    }
  }

  void turn(String playerCast) {
    if (isBattle) {
      for (var element in player.effects) {
        loop.events.add(element.tick());
      }
      loop.events.addAll(getSkill(player, mob, playerCast)!.cast());

      for (var element in mob.effects) {
        loop.events.add(element.tick());
      }
      loop.events.addAll(getSkill(mob, player, mob.cast())!.cast());

      for (var element in loop.events) {
        if (mob.HP <= 0) {
          battleEnd();
          break;
        } else if (player.HP <= 0) {
          battleEnd();
          break;
        }
        log += element.ef();
      }
      loop.events = [];
    }
  }
}
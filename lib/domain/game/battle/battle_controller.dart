
import 'dart:math';

import 'package:arentale/data/service/player_service.dart';
import 'package:arentale/domain/game/battle/battle_loop.dart';
import 'package:arentale/domain/game/game_entities/skill.dart';
import 'package:arentale/domain/player_model.dart';

import '../mob.dart';
import '../player/player.dart';

class BattleController {
  final Player player;
  final PlayerModel playerModel;
  final Mob mob;
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
      log += '\nПолучено: $exp опыта';
      log += '\nПолучено: $gold золота';
      if (drop.isNotEmpty) {
        playerModel.addItems(drop);
        log += '\nПолучено: ${drop.join(', ')}';
      }
      log += '\nВы победили!';
      playerModel.addGold(gold);
      playerModel.addExp(exp);
      playerModel.playerRepository.updateInfo(
          doc: 'info',
          field: 'wins',
          value: 1,
          updateType: DataUpdateType.add
      );
      playerModel.playerRepository.updateInfo(
          doc: 'info',
          field: 'battles',
          value: 1,
          updateType: DataUpdateType.add
      );
      return;
    } else {
      log += '\nВы проиграли!';
      playerModel.playerRepository.updateInfo(
          doc: 'info',
          field: 'battles',
          value: 1,
          updateType: DataUpdateType.add
      );
    }
  }

  void turn(String playerCast) {
    if (isBattle) {
      // for (var element in player.effects) {
      //   loop.events.add(element.tick());
      // }
      player.effectTicks();
      loop.events.addAll(getSkill(player, mob, playerCast)!.cast());

      mob.effectTicks();
      loop.events.addAll(getSkill(mob, player, mob.cast())!.cast());

      for (var element in loop.events) {
        log += element.ef();
      }
      if (mob.HP <= 0 || player.HP <= 0) {
        battleEnd();
      }
      loop.events = [];
    }
  }
}
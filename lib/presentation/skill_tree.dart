import 'package:arentale/domain/game/game_entities/skill.dart';
import 'package:flutter/material.dart';
import 'package:info_popup/info_popup.dart';
import 'package:provider/provider.dart';

import '../domain/game/player/player.dart';
import '../domain/player_model.dart';

class _SkillButton extends StatelessWidget {
  final Skill skill;
  const _SkillButton({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return InfoPopupWidget(
      contentTitle: skill.tooltip,
      child: Image.asset(skill.iconPath!)
    );
  }
}

class _AdvancedClassButton extends StatelessWidget {
  final Image icon;
  final String title;
  final String description;
  final PlayerModel playerModel;
  final String newClass;
  const _AdvancedClassButton({super.key, required this.icon, required this.description, required this.title, required this.playerModel, required this.newClass});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: icon,
        onTap: () {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(title),
              content: Text('$description Нажмите кнопку "Ок", если хотите сменить класс. Это действие нельзя отменить.'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      playerModel.playerRepository.changeClass(newClass);
                    },
                    child: const Text('Ок')
                ),
                TextButton(
                  child: const Text('Назад'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    );
  }
}


class SkillTree extends StatelessWidget {
   const SkillTree({super.key});

   @override
   Widget build(BuildContext context) {
     PlayerModel? playerModel = context.watch<PlayerModel?>();
     if (playerModel == null) {
       return const Center(child: CircularProgressIndicator());
     }
     Player player = playerModel.player;

     final classSkill = {
       'Warrior': {
         1: [
           _SkillButton(skill: getSkillWithoutTarget(player, 'Swing And Cut')!)
         ],
         2: [
           _SkillButton(skill: getSkillWithoutTarget(player, 'Swift Rush')!)
         ],
         3: [
           _SkillButton(skill: getSkillWithoutTarget(player, 'Bloodletting')!)
         ],
         4: [],
         5: [
           _AdvancedClassButton(
             newClass: 'Blade Master',
             playerModel: playerModel,
             title: 'Мастер клинка',
             icon: Image.asset('assets/shining_blade.jpg'),
             description: 'Мастер клинка(основная характеристика: ловкость)\n'
                          'Вы научились мастрески использовать свой клинок, '
                          'используйте свои навыки, чтобы наносить противнику сокрушительные удары'
           ),
           _AdvancedClassButton(
             newClass: 'Berserk',
             playerModel: playerModel,
             title: 'Берсерк',
             icon: Image.asset('assets/battle_lust.jpg'),
             description: 'Берсерк(основная характеристика: сила)\n'
                          'Вы - машина войны. Врывайтесь в самый центр битв, '
                          'наносите противнику яростные удары. Раны делают вас только сильнее'
           ),
           _AdvancedClassButton(
             newClass: 'Guardian',
             playerModel: playerModel,
             title: 'Страж',
             icon: Image.asset('assets/shield_bash.jpg'),
             description: 'Страж(основная характеристика: выносливость)\n'
                 ''
           )
         ]
       },
       'Rogue': {
         1: [
         _SkillButton(skill: getSkillWithoutTarget(player, 'Sneaky blow')!)
         ],
         2: [
           _SkillButton(skill: getSkillWithoutTarget(player, 'Evasion')!)
         ],
         3: [
           _SkillButton(skill: getSkillWithoutTarget(player, 'Experimental Potion')!)
         ],
         4: [],
         5: [
           _AdvancedClassButton(
             newClass: 'Poison Master',
             playerModel: playerModel,
             title: 'Мастер Ядов',
             icon: Image.asset('assets/intoxication.jpg'),
             description: ''
           ),
           _AdvancedClassButton(
             newClass: 'Thug',
             playerModel: playerModel,
             title: 'Головорез',
             icon: Image.asset('assets/blood_fountain.jpg'), 
             description: ''
           ),
           _AdvancedClassButton(
             newClass: 'Shadow',
             playerModel: playerModel,
             title: 'Тень',
             icon: Image.asset('assets/dusk.jpg'),
             description: ''
           )
         ]
       },
       'Mage': {}
     };

     List<Widget> buildSkillTree(String playerClass) {
       List<Widget> result = [];
       for(var e in classSkill[playerClass]!.keys) {
         List<Widget> tmp = [];
         tmp.add(Padding(
           padding: const EdgeInsets.all(20.0),
           child: Text('$e', style: const TextStyle(fontSize: 30)),
         ));
         classSkill[playerClass]![e]!.forEach((element) {
           tmp.add(element);
         });
         while (tmp.length < 5) {
           tmp.add(const SizedBox());
         }
         result.addAll([...tmp]);
       }
       return result;
     }

     return Scaffold(
       appBar: AppBar(
         title: const Text('Skill tree'),
       ),
       body: GridView.count(
         crossAxisCount: 5,
         crossAxisSpacing: 10,
         mainAxisSpacing: 10,
         children: buildSkillTree(player.info['class']),
       ),
     );
   }
 }

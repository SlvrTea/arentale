
import 'package:arentale/presentation/locations/location.dart';
import 'package:arentale/presentation/game_map/map_tile.dart';
import 'package:flutter/material.dart';

class Slinsk extends GameLocation {
  static const _slD = {
    'd1.1': {
      'msg': 'Это небольшой тестовый квест, сделанный для проверки игровых систем. В дальнейших обновлениях вступление может быть переделано.',
      'goto': 'd1.2',
    },
    'd1.2': {
      'msg': 'Колесо телеги налетело на небольшую кочку, выводя вас из полусна. '
          'На горизонте виднелся приграничный город Слинск. '
          'Он занимает важную роль в торговле Восточной Федерации, ведь является единственным городом, через который можно провести товары по суше, минуя хребет красного дракона. '
          'Приближаясь к крепостным стенам Вы замечаете все больше стражи. Оно и не удивительно, уже долгое время ходили слухи, что Святая Империя готовит вторжение в Восточную федерацию. '
          'Вы же прибыли в город потому что...',
      'options': {
        'o1': {
          'msg': 'Я возвращаюсь домой.',
          'goto': 'd1.3',
          'add': [PlayerTags.easternFederationCitizen]
        },
        'o2': {
          'msg': 'На это нет особой причины, я просто скитаюсь по миру',
          'goto': 'd1.3',
          'add': [PlayerTags.nomad]
        },
        'o3': {
          'msg': 'Я наемник и хочу вступить в ополчение',
          'goto': 'd1.3',
          'add': [PlayerTags.mercenary],
          'required': [PlayerTags.warrior]
        },
        'o4': {
          'msg': 'Я путешественник, оказался здесь волею судьбы',
          'goto': 'd1.3',
          'add': [PlayerTags.traveller],
          'required': [PlayerTags.mage]
        },
        'o5': {
          'msg': 'Я разведываю обстановку. Кто-то наверняка дорого заплатит за информацию',
          'goto': 'd1.3',
          'required': [PlayerTags.rogue]
        }
      }
    },
    'd1.3': {
      'msg': 'Когда телега наконец проехала через врата города, вокруг вас стали слышны оживленные улицы  города.'
          'Но весь этот шум не был вызван оживленной торговлей. Похоже ситуация в городе становится все более напряженной. '
          'На улицах было много стражи, а лица прохожих, в основной своей массе, вырожали обеспокоенность.',
      'goto': 'd1.4',
      'options':{
        'o1': {
          'msg': 'Осмотреться',
          'goto': 'd1.3.1',
          'required': [PlayerTags.rogue]
        }
      }
    },
    'd1.3.1': {
      'msg': 'Вы оглядываетесь по сторонам. На первый взгляд кажется, будто город прекрасно защищен, но приглядевшись, '
          'вы замечаете, что большая часть стража - простые ополченцы. Не похоже, что город сможет выдержать натиск святой империи.',
      'goto': 'd1.4'
    },
    'd1.4': {
      'msg': 'Шум понемногу стихал и вы вскоре остановились у довольно уютной на первый взгляд таверны, из которой доносился смех и резкий запах хорошей выпивки. '
          'Сам же извозчик попросил всех высадиться, так как вы достигли конечного пункта, затем отправившись внутрь этого здания. Дальнейшие действия зависят от вас...',
      'goto': 't1.1'
    },
    't1.1': {
      'msg': 'До вас доносится шум и громкий смех, в воздухе повис запах выпивки',
      'options': {
        'o1': {
          'msg': 'Осмотреть таверну',
          'goto': 't1.1.1'
        }
      }
    },
    't1.1.1': {
      'msg': 'Простое на вид помещение, обставленное самой дешевой мебелью. Не смотря на бедное убранство, таверна все равно кажется вам уютной.',
      'goto': 't1.1'
    },
  };
  Slinsk({super.key, super.dialogTree = _slD}) {
    super.locationMobs = ['bat', 'boar'];
    super.locationMap = {
      2: const MapTile(
        toDialog: 'd1.1',
        tooltip: 'Городские ворота',
      ),
      7: MapTile(
        color: Colors.red,
        onTap: () {
          super.startBattle();
        },
      )
    };
  }
}
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Arentale Pre Alpha 0.1`
  String get appbar {
    return Intl.message(
      'Arentale Pre Alpha 0.1',
      name: 'appbar',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get experience {
    return Intl.message(
      'Experience',
      name: 'experience',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get health {
    return Intl.message(
      'Health',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  /// `Mana`
  String get mana {
    return Intl.message(
      'Mana',
      name: 'mana',
      desc: '',
      args: [],
    );
  }

  /// `Attack`
  String get attack {
    return Intl.message(
      'Attack',
      name: 'attack',
      desc: '',
      args: [],
    );
  }

  /// `Spell Power`
  String get spellPower {
    return Intl.message(
      'Spell Power',
      name: 'spellPower',
      desc: '',
      args: [],
    );
  }

  /// `Strength`
  String get strength {
    return Intl.message(
      'Strength',
      name: 'strength',
      desc: '',
      args: [],
    );
  }

  /// `Intelligence`
  String get intelligence {
    return Intl.message(
      'Intelligence',
      name: 'intelligence',
      desc: '',
      args: [],
    );
  }

  /// `Vitality`
  String get vitality {
    return Intl.message(
      'Vitality',
      name: 'vitality',
      desc: '',
      args: [],
    );
  }

  /// `Spirit`
  String get spirit {
    return Intl.message(
      'Spirit',
      name: 'spirit',
      desc: '',
      args: [],
    );
  }

  /// `Dexterity`
  String get dexterity {
    return Intl.message(
      'Dexterity',
      name: 'dexterity',
      desc: '',
      args: [],
    );
  }

  /// `Test Battle`
  String get testBattle {
    return Intl.message(
      'Test Battle',
      name: 'testBattle',
      desc: '',
      args: [],
    );
  }

  /// `Перед своими глазами вы можете видеть небольшую деревню`
  String get slinskD1 {
    return Intl.message(
      'Перед своими глазами вы можете видеть небольшую деревню',
      name: 'slinskD1',
      desc: '',
      args: [],
    );
  }

  /// `Crit Chance`
  String get critChance {
    return Intl.message(
      'Crit Chance',
      name: 'critChance',
      desc: '',
      args: [],
    );
  }

  /// `Crit Damage`
  String get critDamage {
    return Intl.message(
      'Crit Damage',
      name: 'critDamage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

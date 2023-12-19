
import 'package:arentale/internal/dependencies/repository_module.dart';
import 'package:arentale/presentation/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../domain/const.dart';
import '../domain/player_model.dart';
import '../generated/l10n.dart';

class Application extends StatelessWidget {
  const Application({super.key,});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<PlayerModel?>(
      create: (_) => RepositoryModule
          .playerRepository()
          .getPlayer()
          .then((value) => PlayerModel(player: value)),
      initialData: null,
      child: MaterialApp(
        title: 'Arentale',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        navigatorKey: navigatorKey,
        locale: const Locale('ru', 'RU'),
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark
          )
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
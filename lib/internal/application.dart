
import 'package:arentale/presentation/home.dart';
import 'package:arentale/presentation/login_screen.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arentale Pre Alpha',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.dark
        )
      ),
      home: const LoginScreen(),
    );
  }

}
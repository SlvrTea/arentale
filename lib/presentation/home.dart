import 'package:arentale/domain/state/player/player_bloc.dart';
import 'package:arentale/presentation/charInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/state/navigation_state.dart';
import 'battle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key, required this.uuid});
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
              create: (context) => NavigationBloc()
          ),
          BlocProvider<PlayerBloc>(
              create: (context) => PlayerBloc()
          )
        ],
        child: Home(uuid: uuid)
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.uuid});
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text(AppLocalizations.of(context)!.appbar)),
          body: BlocBuilder<NavigationBloc, int>(
            builder: (context, state) {
              return _getBody(context)[state];
            },
          ),
          bottomNavigationBar: _getNavigationBar(),
          drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(uuid)
              ],
            ),
          ),
        );
      }
    );
  }

  List<Widget> _getBody(context) {
    return <Widget>[
      Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const Battle())
            );
          },
          child: const Text('Battle Test'),

        ),
      ),
      const Center(child: Text('Map')),
      const CharInfo()
    ];
  }

  Widget _getNavigationBar() {
    return BlocBuilder<NavigationBloc, int>(
      builder: (context, state) {
        return NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: state,
          onDestinationSelected: (int index) {
            BlocProvider.of<NavigationBloc>(context).add(
                NavigationChangeEvent(value: index));
          },
          destinations: const <Widget>[
            NavigationDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_outlined),
                label: 'Home'
            ),
            NavigationDestination(
                icon: Icon(Icons.map),
                selectedIcon: Icon(Icons.map_outlined),
                label: 'Map'
            ),
            NavigationDestination(
                icon: Icon(Icons.account_circle),
                selectedIcon: Icon(Icons.account_circle_outlined),
                label: 'Char'
            )
          ],
        );
      },
    );
  }
}
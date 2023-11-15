import 'package:arentale/presentation/charInfo.dart';
import 'package:arentale/presentation/locations/slinsk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/state/navigation_state.dart';
import '../generated/l10n.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key, required this.uuid});
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: Home(uuid: uuid),
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
          appBar: AppBar(title: Text(S.of(context).appbar)),
          body: BlocBuilder<NavigationBloc, int>(
            builder: (context, state) {
              return _getBody()[state];
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

  List<Widget> _getBody() {
    return <Widget>[
      const Slinsk(),
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
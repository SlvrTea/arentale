import 'package:arentale/domain/state/player_bloc.dart';
import 'package:arentale/presentation/charInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../domain/state/navigation_state.dart';

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
          appBar: AppBar(title: const Text('Arentale Pre Alpha')),
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
      Center(
          child: CircularPercentIndicator(
            radius: 50,
            header: const Text('Win rate'),
            progressColor: Colors.red,
            center: const Text('100%'),
          )
      ),
      const Center(child: Text('Map')),
      const CharInfo()
    ];
  }

  Widget _getNavigationBar() {
    return BlocBuilder<NavigationBloc, int>(
      builder: (context, state) {
        return NavigationBar(
          selectedIndex: state,
          onDestinationSelected: (int index) {
            BlocProvider.of<NavigationBloc>(context).add(
                NavigationChangeEvent(value: index));
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            NavigationDestination(
                icon: Icon(Icons.map),
                label: 'Map'
            ),
            NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Char'
            )
          ],
        );
      },
    );
  }
}
import 'package:desafio_flutter/views/confirm_email.dart';
import 'package:desafio_flutter/views/home.dart';
import 'package:desafio_flutter/views/profile.dart';
import 'package:flutter/material.dart';

//pagina principal, que contem a barra de navegação e área para usuários logados

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const MyHomePage(title: 'Home');
        break;
      case 1:
        page = const ProfileScreen();
        break;
      case 2:
        page = const ConfirmEmailScreen();
        break;
      default:
        throw UnimplementedError();
    }
    var theme = Theme.of(context);
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              backgroundColor: theme.colorScheme.inversePrimary,
              extended: false,
              destinations: const[
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Profile'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.check), 
                  label: Text('Confirm Email'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}
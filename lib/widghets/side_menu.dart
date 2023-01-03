import 'package:admin_bet_hint/provider/dark_theme_provider.dart';
import 'package:admin_bet_hint/screens/all_games.dart';
import 'package:admin_bet_hint/screens/dashboard_screen.dart';
import 'package:admin_bet_hint/screens/game_outcome_history.dart';
import 'package:admin_bet_hint/screens/main_screen.dart';
import 'package:admin_bet_hint/services/utils.dart';
import 'package:admin_bet_hint/widghets/text_widghet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_list_tile.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = Utils(context).color;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('lib/assets/images/ball-157860.png'),
          ),
          DrawerListTile(
            icon: Icons.home,
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            tittle: 'Main',
          ),
          DrawerListTile(
            icon: Icons.store,
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllGamesScreen(),
                ),
              );
            },
            tittle: 'View All games',
          ),
          DrawerListTile(
            icon: Icons.history,
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameHistoryScreen(),
                ),
              );
            },
            tittle: 'Games history',
          ),
          DrawerListTile(
            icon: Icons.shopping_bag,
            press: () {},
            tittle: 'Subscriptions',
          ),
          SwitchListTile(
            title: TextWidget(
              text: themeState.getDarkTheme ? "Dark Mode" : "Light Mode",
              maxLines: 1,
              color: color,
              textSize: 18,
              isTitle: false,
            ),
            secondary: Icon(
              themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            onChanged: (bool value) {
              setState(() {
                themeState.setDarkTheme = value;
              });
            },
            value: themeState.getDarkTheme,
          ),
        ],
      ),
    );
  }
}

class IconslyBold {}

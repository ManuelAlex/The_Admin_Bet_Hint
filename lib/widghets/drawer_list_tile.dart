import 'package:admin_bet_hint/provider/dark_theme_provider.dart';
import 'package:admin_bet_hint/services/utils.dart';
import 'package:admin_bet_hint/widghets/text_widghet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//////////

class DrawerListTile extends StatelessWidget {
  final String tittle;
  final void Function() press;
  final IconData icon;
  const DrawerListTile(
      {Key? key, required this.tittle, required this.press, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = Utils(context).color;
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        size: 18,
      ),
      title: TextWidget(
        text: tittle,
        maxLines: 1,
        color: color,
        textSize: 18,
      ),
    );
  }
}

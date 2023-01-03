import 'package:admin_bet_hint/controllers/menu_controller.dart';
import 'package:admin_bet_hint/screens/dashboard_screen.dart';
import 'package:admin_bet_hint/widghets/responsive.dart';
import 'package:admin_bet_hint/widghets/side_menu.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:provider/src/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().getscalffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDestop(context))
              const Expanded(
                child: SideMenu(),
              ),
            const Expanded(
              flex: 5,
              child: DashBoardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

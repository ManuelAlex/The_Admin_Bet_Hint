import 'package:admin_bet_hint/widghets/responsive.dart';
import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final void Function() onpress;
  final String text;
  final IconData icon;
  final Color backgroundColor;
  const DashboardButton(
      {Key? key,
      required this.onpress,
      required this.text,
      required this.icon,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(
                horizontal: 8 * 1.5,
                vertical: 8 / (Responsive.isDestop(context) ? 1 : 2))),
        onPressed: () {
          onpress();
        },
        icon: Icon(
          icon,
          size: 20,
        ),
        label: Text(text));
  }
}

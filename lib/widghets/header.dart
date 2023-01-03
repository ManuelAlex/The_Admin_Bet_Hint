import 'package:admin_bet_hint/services/utils.dart';
import 'package:admin_bet_hint/widghets/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Function fct;
  final String title;
  final bool showTextField;
  const Header({
    Key? key,
    required this.fct,
    required this.title,
    this.showTextField = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;
    return Row(
      children: [
        if (!Responsive.isDestop(context))
          IconButton(
            onPressed: () {
              fct();
            },
            icon: const Icon(Icons.menu),
          ),
        if (Responsive.isDestop(context))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        if (Responsive.isDestop(context))
          Spacer(
            flex: Responsive.isDestop(context) ? 2 : 1,
          ),
        !showTextField
            ? Container()
            : Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'search',
                    fillColor: Theme.of(context).cardColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

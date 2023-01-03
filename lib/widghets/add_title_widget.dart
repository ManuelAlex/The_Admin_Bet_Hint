import 'package:admin_bet_hint/services/utils.dart';
import 'package:admin_bet_hint/widghets/text_widghet.dart';
import 'package:flutter/material.dart';

class AddTitleWidget extends StatelessWidget {
  final TextEditingController controller;
  final String textTitle, titlekey, returnText;

  const AddTitleWidget(
      {Key? key,
      required this.controller,
      required this.textTitle,
      required this.titlekey,
      required this.returnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    final theme = Utils(context).getTheme;
    final size = Utils(context).getscreenSize;
    final _scalfoldColor = Theme.of(context).scaffoldBackgroundColor;
    final _formKey = GlobalKey<FormState>();

    var inPutDecoration = InputDecoration(
      filled: true,
      fillColor: _scalfoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextWidget(
            text: textTitle,
            color: color,
            textSize: 18,
            isTitle: true,
          ),
        ),
        TextFormField(
          controller: controller,
          key: ValueKey(titlekey),
          validator: (value) {
            if (value!.isEmpty) {
              return returnText;
            }
            return null;
          },
          decoration: inPutDecoration,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../widghets/text_widghet.dart';

class GlobalMethods {
  navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'lib/assets/images/sign-42530_1280.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 8),
                const SizedBox(height: 8),
                const Text('An Error Occured'),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(text: 'Ok', color: Colors.cyan, textSize: 18),
              ),
            ],
          );
        });
  }

  // static Future<void> warningDialog({
  //   required String title,
  //   required String subtitle,
  //   required Function() fct,
  //   required BuildContext context,
  // }) async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Row(
  //             children: [
  //               Image.asset(
  //                 'lib/assets/images/sign-42530_1280.png',
  //                 height: 30,
  //                 width: 30,
  //                 fit: BoxFit.fill,
  //               ),
  //               const SizedBox(width: 8),
  //               const SizedBox(height: 8),
  //               Text(title),
  //             ],
  //           ),
  //           content: Text(subtitle),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 if (Navigator.canPop(context)) {
  //                   Navigator.pop(context);
  //                 }
  //               },
  //               child: TextWidget(
  //                   text: 'Cancel', color: Colors.cyan, textSize: 18),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 fct;
  //                 if (Navigator.canPop(context)) {
  //                   Navigator.pop(context);
  //                 }
  //               },
  //               child: TextWidget(text: 'Ok', color: Colors.cyan, textSize: 18),
  //             ),
  //           ],
  //         );
  //       });
  // }
}

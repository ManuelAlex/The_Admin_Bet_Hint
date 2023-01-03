import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: const Icon(
        IconlyLight.arrowLeft2,
        color: Colors.blue,
        size: 24,
      ),
    );
  }
}

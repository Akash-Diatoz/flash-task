import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class CuntomButtonWidget extends StatelessWidget {
  const CuntomButtonWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kWhiteColor,
          size: 30,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

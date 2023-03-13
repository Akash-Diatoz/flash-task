import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              height: size.width * 0.6,
              width: size.width * 0.15,
            ),
            Container(
              width: size.width * 0.4,
              height: size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://www.themoviedb.org/t/p/w220_and_h330_face/sHim6U0ANsbzxcmNRYuIubBVQaz.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
        Positioned(
          left: 10,
          bottom: -30,
          child: BorderedText(
            strokeWidth: 5.0,
            strokeColor: kWhiteColor,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                fontSize: 140,
                color: kBlackColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                decorationColor: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

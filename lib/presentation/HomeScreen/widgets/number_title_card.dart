import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import 'main_title.dart';
import 'number_cards.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key,
    required this.limitedSize,
  }) : super(key: key);

  final double limitedSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(
          title: "Top 10 shows in India Today ",
        ),
        khight,
        LimitedBox(
            maxHeight: limitedSize,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return NumberCard(index: index);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 25,
                  );
                }))
      ],
    );
  }
}

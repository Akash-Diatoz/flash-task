import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import 'mainCard_Widget.dart';
import 'main_title.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({Key? key, required this.size, required this.title})
      : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(
            title: title,
          ),
          khight,
          LimitedBox(
              maxHeight: size.width * 0.6,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return HomePageCard(
                      widthSize: size.width * 0.4,
                      heightSize: size.width * 0.6,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 25,
                    );
                  })
              // child: ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: List.generate(
              //       10,
              //       (index) => HomePageCard(
              //             widthSize: size.width * 0.5,
              //             heightSize: size.width * 0.8,
              //           )),
              // ),
              )
        ],
      ),
    );
  }
}

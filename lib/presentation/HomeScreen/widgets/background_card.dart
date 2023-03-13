import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';
import 'custome_button_widget.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.width * 1.5,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(kMainImage),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CuntomButtonWidget(
                icon: Icons.add,
                title: "My List",
              ),
              _playButton(),
              const CuntomButtonWidget(
                icon: Icons.info_outline,
                title: "Info",
              ),
            ],
          ),
        )
      ],
    );
  }

  TextButton _playButton() {
    return TextButton.icon(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhiteColor)),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        size: 30,
        color: kBlackColor,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          "Play",
          style: TextStyle(
            fontSize: 20,
            color: kBlackColor,
          ),
        ),
      ),
    );
  }
}

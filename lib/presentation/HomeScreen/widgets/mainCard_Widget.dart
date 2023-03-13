import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard(
      {Key? key, required this.widthSize, required this.heightSize})
      : super(key: key);

  final double widthSize;
  final double heightSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: heightSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
            image: NetworkImage(
                "https://www.themoviedb.org/t/p/w220_and_h330_face/th6vfqUtkGx69NI9TGa9gpOl7xg.jpg"),
            fit: BoxFit.cover),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kwidht = SizedBox(width: 5);

const khight = SizedBox(height: 5);

const khight20 = SizedBox(height: 20);

//BorderRadius
final BorderRadius kRadius20 = BorderRadius.circular(20);

const kMainImage =
    "https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/c73bc7c503920b61c100eab128e70d5e.jpe";

TextStyle kHomeTitleText = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Center(
        child: Text(
          'Alert',
          style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
        ),
      ),
      content: Text(
        message,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 13,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w400,
        )),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: Text('OK!'),
        )
      ],
    ),
  );
}

const String loginRoute = "Login";
const String logout = "Logout";

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetask/application/firebase_analytics.dart';
import 'package:firetask/infrastructure/locator.dart';
import 'package:firetask/presentation/HomeScreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants.dart';
import '../../main.dart';
import 'googleSignin.dart';
import 'googleSigninMethod.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePassword = true;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Colors.pinkAccent,
      body: ListView(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Text(
              "DIATOZ",
              style: TextStyle(fontSize: 23, color: Colors.white70),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 55, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              // color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                    offset: Offset(0, 10),
                    blurRadius: 20)
              ],
            ),
            child: Form(
              key: globalFormKey,
              child: Column(
                children: [
                  Text(
                    "PROJECT MANAGEMENT",
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Login".toUpperCase(),
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    // style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    validator: (input) {
                      if ((input!.isEmpty) &&
                          RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(input)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter your email address",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    keyboardType: TextInputType.text,
                    // onSaved: (input) => loginRequestModel!.password = input!,
                    validator: (input) => input!.length < 4
                        ? "Password should be more than 4 characters"
                        : null,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4),
                        icon: hidePassword == false
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      if (validateAndSave()) {
                        signIn();
                      } else {
                        await _analyticsService.logFailed();
                        showErrorDialog(
                            context, "Please enter the correct credentials.");
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    // color: Theme.of(context).accentColor,
                    // shape: StadiumBorder(),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            onPressed: () async {
              await _analyticsService.logLogin();
              GoogleSignInProvider().googleLogin();
              // final provider =
              //     Provider.of<GoogleSignInProvider>(context, listen: false);
              // provider.googleLogin();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/google_logo.png"),
                    height: 35.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await _analyticsService.logLogin();
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      await _analyticsService.logFailed();
      print(e);
      // showErrorDialog(context, "Please enter the correct credentials.");
    }
    // await _analyticsService.logLogin();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

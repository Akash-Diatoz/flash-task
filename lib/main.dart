import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firetask/presentation/LoginPage/login_page.dart';
import 'package:firetask/presentation/HomeScreen/main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/colors.dart';
import 'core/constants.dart';
import 'firebase_options.dart';
import 'infrastructure/remote_config.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: kBlackColor),
          scaffoldBackgroundColor: backgroundColor,
          primarySwatch: Colors.blue,
          backgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          ),
        ),
        home: const MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return showErrorDialog(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return ScreenHome();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}

// class Home extends AnimatedWidget {
//   final FirebaseRemoteConfig remoteConfig;
//   Home({required this.remoteConfig}):super(listenable: remoteConfig)
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<FirebaseRemoteConfig>(
//         future: FirebaseRemoteConfigClass().setupRemoteConfig(),
//         builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot)(
//         return snapshot.hasData
//         )
//
//       ),
//     );
//   }
//
// }

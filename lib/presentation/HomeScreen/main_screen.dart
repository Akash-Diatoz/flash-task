import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firetask/application/widget_map.dart';
import 'package:firetask/core/utile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../application/firebase_analytics.dart';
import '../../domain/loginModel.dart';
import '../../infrastructure/locator.dart';
import '../../infrastructure/remote_config.dart';
import '../LoginPage/googleSignin.dart';
import 'notifier.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final dataNotifier = DataValueNotifier();
  final util = Util();
  late User _user;
  bool _isSigningOut = false;
  List<String> serverString = [];
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  @override
  void initState() {
    super.initState();
    () async {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ));
    }();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.setDefaults(<String, dynamic>{});
    final GoogleSignIn googleSignIn = GoogleSignIn();

    void showLoading(BuildContext context) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8.0),
                Text('Loading...')
              ],
            ),
          );
        },
      );
    }

    Future<void> _syncData() async {
      showLoading(context);
      try {
        await remoteConfig.fetchAndActivate();
        final rs = remoteConfig.getString("logout_alert");
        dataNotifier.value = await util.parseJsonConfig(rs);
        Navigator.pop(context); // hide loading
      } catch (e) {
        print(e);
      }
    }

    // Map<String, dynamic> mapValues =
    //     json.decode(remoteConfig.getValue("logout_alert").asString());

    return FutureBuilder<FirebaseRemoteConfig>(
      future: setupRemoteConfig(),
      builder:
          (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
        return snapshot.hasData
            ? ValueListenableBuilder(
                valueListenable: dataNotifier,
                builder: (context, LogoutData? value, child) {
                  return Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Alert'),
                                content: Text('${value?.logoutMessage}'),
                                // Text(
                                //     "${remoteConfig.getString(mapValues["logout_message"])}"),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: Text('${value?.btnNo}'),
                                    // Text("${mapValues['btn_no']}"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: Text('${value?.btnYes}'),
                                    // Text("${mapValues['btn_yes']}"),
                                    onPressed: () async {
                                      await _analyticsService.logOut();
                                      // GoogleSignInProvider().logout();
                                      googleSignIn.signOut();
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Icon(Icons.logout),
                    ),
                    body: Center(
                      child: Text(
                        remoteConfig.getString('welcome_message'),
                      ),
                    ),
                  );
                })
            : Scaffold(
                body: Container(
                  child: const Center(
                    child: Text("Please check your connection"),
                  ),
                ),
              );
      },
    );
  }
}

Future<FirebaseRemoteConfig> setupRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.fetch();
  await remoteConfig.activate();

//testing
  print(remoteConfig.getString("welcome_message"));
  print(remoteConfig.getString('logout_alert'));

  return remoteConfig;
}

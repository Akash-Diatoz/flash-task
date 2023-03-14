import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firetask/application/widget_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../infrastructure/remote_config.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Widget> serverWidgets = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVal();
  }

  getVal() async {
    var serverJsonList = (await FirebaseRemoteConfigClass().initializeConfig());
    setState(() {
      serverWidgets = MapDataToWidget().mapWidgets(serverJsonList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    var rawData = jsonDecode(remoteConfig.getValue('logout_alert').asString());
    const defaultValue = {
      "title": "Hello, World!",
    };
    return FutureBuilder<FirebaseRemoteConfig>(
      future: setupRemoteConfig(),
      builder:
          (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
        return snapshot.hasData
            ? Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Alert'),
                            content: Text("${rawData['logout_message']}"),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: Text("${rawData['btn_no']}"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: Text("${rawData['btn_yes']}"),
                                onPressed: () {
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
                    child: Text(remoteConfig.getString('welcome_message'))))
            : Scaffold(
                body: Container(
                  child: Text("No data available"),
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
  // print(remoteConfig.getString("logout_message"));

  return remoteConfig;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firetask/application/widget_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Widget> serverWidgets = [];
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getVal();
  // }

  // getVal() async {
  //   var serverJsonList = (await FirebaseRemoteConfigClass().initializeConfig());
  //   setState(() {
  //     serverWidgets = MapDataToWidget().mapWidgets(serverJsonList);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Alert'),
                  content: const Text('Do you want to logout'),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Yes'),
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
      body: const Center(
        child: Text(
          "Welcome message to be shown to users",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

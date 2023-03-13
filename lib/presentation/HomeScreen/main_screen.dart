import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firetask/application/widget_map.dart';
import 'package:firetask/presentation/HomeScreen/widgets/Main_title_card.dart';
import 'package:firetask/presentation/HomeScreen/widgets/background_card.dart';
import 'package:firetask/presentation/HomeScreen/widgets/number_title_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../infrastructure/remote_config.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

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
    return Scaffold(
        body: SafeArea(
      child: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (context, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final direction = notification.metrics;
              if (direction.atEdge) {
                scrollNotifier.value = true;
              } else {
                scrollNotifier.value = false;
              }
              return true;
            },
            child: Stack(
              children: [
                ListView(
                  physics: ClampingScrollPhysics(),
                  children: [
                    const BackgroundCard(),
                    MainTitleCard(
                      size: size,
                      title: "Released in the past year",
                    ),
                    khight,
                    MainTitleCard(
                      size: size,
                      title: "Trending Now",
                    ),
                    khight,
                    NumberTitleCard(
                      limitedSize: size.width * 0.6,
                    ),
                    khight,
                    MainTitleCard(
                      size: size,
                      title: "Tense Dramas",
                    ),
                    khight,
                    MainTitleCard(
                      size: size,
                      title: "South Indian Cinemas",
                    ),
                    khight,
                  ],
                ),
                scrollNotifier.value == true
                    ? Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.black.withOpacity(0.2),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ...serverWidgets,
                                  Image.network(
                                    'https://play-lh.googleusercontent.com/TBRwjS_qfJCSj1m7zZB93FnpJM5fSpMA_wUlFDLxWAb45T9RmwBvQd5cWR5viJJOhkI',
                                    width: size.width * 0.12,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.cast,
                                        color: kWhiteColor,
                                        size: 30,
                                      ),
                                      kwidht,
                                      Container(
                                        height: 30,
                                        width: 30,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            khight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "TV Shows",
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  "Movies",
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  "Categories",
                                  style: kHomeTitleText,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    : khight
              ],
            ),
          );
        },
      ),
    ));
  }
}

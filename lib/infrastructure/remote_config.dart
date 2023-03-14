import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigClass {
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future initializeConfig() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 1),
        minimumFetchInterval: Duration(seconds: 1),
      ),
    );
    await remoteConfig.fetchAndActivate();
    var temp = remoteConfig.getString("MyWidget");
    return temp;
  }

  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.fetch();
    await remoteConfig.activate();

//testing
    print(remoteConfig.getString("Text"));

    return remoteConfig;
  }

  // Future initialzeString() async {
  //   await remoteConfig.setConfigSettings(
  //     RemoteConfigSettings(
  //       fetchTimeout: Duration(seconds: 1),
  //       minimumFetchInterval: Duration(seconds: 1),
  //     ),
  //   );
  //   await remoteConfig.fetchAndActivate();
  //   var temp = remoteConfig.getString("StringData");
  //   return temp;
  // }
}

// class RemoteCofigService {
//   final remoteConfig = FirebaseRemoteConfig.instance;
//
//   static RemoteCofigService? _instance;
//   static Future<RemoteCofigService> getInstance() async {
//     if (_instance == null) {
//       _instance = RemoteCofigService(
//         remoteConfig: await FirebaseRemoteConfig.instance,
//       );
//     }
//   }
//   return _instance;
// }

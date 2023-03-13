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
}

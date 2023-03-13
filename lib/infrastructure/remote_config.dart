import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfig {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig;
  Future<void> _fetchRemoteConfig() async {
    try {
      // Set the default values for the remote config variables
      final defaults = <String, dynamic>{'my_variable': 'default_value'};
      await _remoteConfig.setDefaults(defaults);

      // Fetch the remote config variables
      await _remoteConfig.fetch();
      await _remoteConfig.activate();

      // Get the value of a remote config variable
      final myVariable = _remoteConfig.getString('my_variable');
      print('my_variable: $myVariable');
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }
// final remoteConfig = FirebaseRemoteConfig.instance;

}

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/remote_config_updater.dart';

class FirebaseRemoteConfigWrapper extends RemoteConfigUpdater {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> setConfigSettings({
    required Duration fetchTimeout,
    required Duration minimumFetchInterval,
  }) async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: fetchTimeout,
      minimumFetchInterval: minimumFetchInterval,
    ));
  }

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  Stream<RemoteConfigUpdate> onConfigUpdated() {
    return _remoteConfig.onConfigUpdated;
  }

  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  String getString(String key) {
    return _remoteConfig.getString(key);
  }

  @override
  bool existsOnRemote(String key) {
    return FirebaseRemoteConfig.instance.getValue(key).source ==
        ValueSource.valueRemote;
  }
}

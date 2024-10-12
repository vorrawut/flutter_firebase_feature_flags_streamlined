import 'package:firebase_remote_config/firebase_remote_config.dart';

extension FeatureFlagExtension on String {
  bool isEnabled() {
    return FirebaseRemoteConfig.instance.getBool(this);
  }
}

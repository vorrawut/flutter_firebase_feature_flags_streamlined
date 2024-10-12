import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_firebase_feature_flags/firebase/feature_flag_domain.dart';

class FeatureFlagService {
  // Initialize all flags at the beginning, without needing it in the target class
  Future<void> initializeAllFlags(List<FeatureFlagDomain> domains) async {
    final defaults = getAllFeatureFlagDefaults(domains);
    await FirebaseRemoteConfig.instance.setDefaults(defaults);

    // Fetch and activate for the initial setup
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  }

  // Method to gather defaults
  Map<String, bool> getAllFeatureFlagDefaults(List<FeatureFlagDomain> domains) {
    final Map<String, bool> defaults = {};

    for (var domain in domains) {
      defaults.addAll(domain.overriddenDefaults);
      for (var flag in domain.featureFlags) {
        defaults.putIfAbsent(flag, () => false); // Default to false
      }
    }

    return defaults;
  }
}

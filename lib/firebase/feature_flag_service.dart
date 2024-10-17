import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_firebase_feature_flags/firebase/domains/feature_flag_domain.dart';

class FeatureFlagService {
  Future<void> initializeAllFlags(List<FeatureFlagDomain> domains) async {
    final defaults = getAllFeatureFlagDefaults(domains);
    await FirebaseRemoteConfig.instance.setDefaults(defaults);

    // Fetch and activate the latest config
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  }

  Map<String, dynamic> getAllFeatureFlagDefaults(
      List<FeatureFlagDomain> domains) {
    final Map<String, dynamic> defaults = {};

    for (var domain in domains) {
      defaults.addAll(domain.overriddenDefaults);
      for (var flag in domain.featureFlags) {
        defaults.putIfAbsent(
            flag.key, () => flag.initialValue); // Default values
      }
    }

    return defaults;
  }
}

import 'package:flutter_firebase_feature_flags/firebase/utils/base_feature_flag.dart';

// Abstract class for feature flag domains
abstract class FeatureFlagDomain {
  // Map of default values for feature flags (supports multiple types)
  Map<String, dynamic> get overriddenDefaults;

  // List of all feature flags (supports multiple types)
  List<BaseFeatureFlag> get featureFlags;
}

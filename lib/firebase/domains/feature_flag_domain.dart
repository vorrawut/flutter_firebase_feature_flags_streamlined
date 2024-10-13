import 'package:flutter_firebase_feature_flags/firebase/utils/base_feature_flag.dart';

abstract class FeatureFlagDomain {
  // Default values for flags, if needed
  Map<String, dynamic> get overriddenDefaults;

  // List of all flags in this domain
  List<BaseFeatureFlag> get featureFlags;

  // Flags that need real-time syncing
  List<BaseFeatureFlag> get realtimeSyncFlags;
}

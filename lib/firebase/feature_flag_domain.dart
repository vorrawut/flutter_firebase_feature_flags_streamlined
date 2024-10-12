abstract class FeatureFlagDomain {
  Map<String, bool> get overriddenDefaults;
  List<String> get featureFlags;
}

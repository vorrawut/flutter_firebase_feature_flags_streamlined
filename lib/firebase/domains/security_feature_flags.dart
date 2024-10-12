import 'package:flutter_firebase_feature_flags/firebase/feature_flag_domain.dart';

class SecurityFeatureFlags extends FeatureFlagDomain {
  static const enableEncryptionTemporary = 'security_encryption_20241003';

  @override
  Map<String, bool> get overriddenDefaults => {
        enableEncryptionTemporary: true,
      };

  @override
  List<String> get featureFlags => [
        enableEncryptionTemporary,
      ];
}

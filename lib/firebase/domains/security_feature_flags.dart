import 'package:flutter_firebase_feature_flags/firebase/domains/feature_flag_domain.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/base_feature_flag.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/bool_feature_flag.dart';

class SecurityFeatureFlags extends FeatureFlagDomain {
  static final enableEncryptionTemporary =
      BoolFeatureFlag(key: 'security_encryption_20241003');

  @override
  Map<String, dynamic> get overriddenDefaults => {
        enableEncryptionTemporary.key: true,
      };

  @override
  List<BaseFeatureFlag> get featureFlags => [
        enableEncryptionTemporary,
      ];

  @override
  List<BaseFeatureFlag> get realtimeSyncFlags => [];
}

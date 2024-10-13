import 'package:flutter_firebase_feature_flags/firebase/domains/feature_flag_domain.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/base_feature_flag.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/bool_feature_flag.dart';

class OnboardingFeatureFlags extends FeatureFlagDomain {
  static final enableNewUserFlow =
      BoolFeatureFlag(key: 'onboarding_enable_new_user_flow');
  static final enableReferrals =
      BoolFeatureFlag(key: 'onboarding_enable_referrals');

  @override
  Map<String, dynamic> get overriddenDefaults => {
        enableNewUserFlow.key: false,
        enableReferrals.key: true,
      };

  @override
  List<BaseFeatureFlag> get featureFlags => [
        enableNewUserFlow,
        enableReferrals,
      ];

  @override
  List<BaseFeatureFlag> get realtimeSyncFlags => [
        enableNewUserFlow, // Only sync this flag in real-time
      ];
}

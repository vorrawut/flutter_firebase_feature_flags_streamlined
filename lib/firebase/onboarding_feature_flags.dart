import 'package:flutter_firebase_feature_flags/firebase/feature_flag_domain.dart';

class OnboardingFeatureFlags extends FeatureFlagDomain {
  static const enableNewUserFlow = 'onboarding_enable_new_user_flow';
  static const enableReferrals = 'onboarding_enable_referrals';

  @override
  Map<String, bool> get overriddenDefaults => {
        enableNewUserFlow: true,
      };

  @override
  List<String> get featureFlags => [
        enableNewUserFlow,
        enableReferrals,
      ];
}

import 'package:flutter_firebase_feature_flags/firebase/domains/feature_flag_domain.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/base_feature_flag.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/bool_feature_flag.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/string_feature_flag.dart';

class OnboardingFeatureFlags extends FeatureFlagDomain {
  // Define Boolean flags
  static final enableNewUserFlow = BoolFeatureFlag(
    key: 'onboarding_enable_new_user_flow',
    initialValue: false,
  );
  static final enableReferrals = BoolFeatureFlag(
    key: 'onboarding_enable_referrals',
    initialValue: true,
  );

  // Define a String flag for the welcome message
  static final welcomeMessage = StringFeatureFlag(
    key: 'onboarding_welcome_message',
    initialValue: 'Welcome to our app!',
  );

  @override
  Map<String, dynamic> get overriddenDefaults => {
        enableNewUserFlow.key: false,
        enableReferrals.key: true,
        welcomeMessage.key: 'Welcome to our app!',
      };

  @override
  List<BaseFeatureFlag> get featureFlags => [
        enableNewUserFlow,
        enableReferrals,
        welcomeMessage,
      ];
}

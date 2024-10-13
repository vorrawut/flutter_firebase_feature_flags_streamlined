import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_firebase_feature_flags/firebase/domains/feature_flag_domain.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/firebase_remote_config_wrapper.dart';
import 'package:flutter_firebase_feature_flags/utils/locator.dart';
import 'package:flutter_firebase_feature_flags/utils/network_info.dart';

class FeatureFlagService {
  late FirebaseRemoteConfigWrapper firebaseRemoteConfigWrapper;
  late NetworkInfo networkInfo;
  bool isInitialized = false;

  Future<void> setup(
    List<FeatureFlagDomain> domains,
  ) async {
    await _initialize(domains);
    await _updateAllFlags(domains); // Initial sync of all feature flags

    firebaseRemoteConfigWrapper.onConfigUpdated().listen((event) {
      _updateAllFlags(
        domains,
        isRealtimeOnly: true,
      ); // Sync only real-time flags
    });
  }

  Future<void> _initialize(
    List<FeatureFlagDomain> domains,
  ) async {
    firebaseRemoteConfigWrapper = locator<FirebaseRemoteConfigWrapper>();
    networkInfo = locator<NetworkInfo>();

    final defaults = getAllFeatureFlagDefaults(domains);
    await FirebaseRemoteConfig.instance.setDefaults(defaults);

    await firebaseRemoteConfigWrapper.setConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: const Duration(minutes: 1),
    );

    isInitialized = true;
  }

  // Method to gather defaults
  Map<String, dynamic> getAllFeatureFlagDefaults(
    List<FeatureFlagDomain> domains,
  ) {
    final Map<String, dynamic> defaults = {};

    for (var domain in domains) {
      defaults.addAll(domain.overriddenDefaults);
      for (var flag in domain.featureFlags) {
        defaults.putIfAbsent(flag.key, () => false); // Default to false
      }
    }

    return defaults;
  }

  Future<void> _updateAllFlags(
    List<FeatureFlagDomain> domains, {
    bool isRealtimeOnly = false,
  }) async {
    if (!isInitialized) {
      await _initialize(domains);
    }

    if (!await networkInfo.isConnected) {
      return; // Skip if no network
    }

    await firebaseRemoteConfigWrapper.fetchAndActivate();

    // Sync the flags based on the isRealtimeOnly flag
    _syncValue(
      firebaseRemoteConfigWrapper,
      domains,
      isRealtimeOnly: isRealtimeOnly,
    );
  }

  void _syncValue(
    FirebaseRemoteConfigWrapper remoteConfigWrapper,
    List<FeatureFlagDomain> domains, {
    bool isRealtimeOnly = false,
  }) {
    // Filter domains based on whether they should sync in real-time
    final syncDomains = isRealtimeOnly
        ? domains.where((domain) => domain.realtimeSyncFlags.isNotEmpty)
        : domains;

    for (var syncDomain in syncDomains) {
      for (var flag in syncDomain.featureFlags) {
        flag.syncValue(remoteConfigWrapper); // Call syncValue on FeatureFlag
      }
    }
  }
}

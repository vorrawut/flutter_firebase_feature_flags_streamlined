import 'package:flutter_firebase_feature_flags/firebase/feature_flag_service.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/firebase_remote_config_wrapper.dart';
import 'package:flutter_firebase_feature_flags/utils/network_info.dart';
import 'package:flutter_firebase_feature_flags/utils/network_info_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register FirebaseRemoteConfigWrapper as a singleton
  locator.registerLazySingleton<FirebaseRemoteConfigWrapper>(
      () => FirebaseRemoteConfigWrapper());

  // Register FeatureFlagService as a singleton
  locator.registerLazySingleton<FeatureFlagService>(() => FeatureFlagService());

  // Register NetworkInfo to check network status
  locator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(Connectivity()));
}

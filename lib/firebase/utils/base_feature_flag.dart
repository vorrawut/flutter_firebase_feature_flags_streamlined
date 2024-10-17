import 'package:flutter_firebase_feature_flags/firebase/utils/feature_value_notifier.dart';
import 'package:flutter_firebase_feature_flags/firebase/utils/remote_config_updater.dart';

// Base class for all feature flags, supporting various data types (bool, int, String).
abstract class BaseFeatureFlag<T> {
  // Key identifying the feature flag in Firebase Remote Config.
  final String key;

  // Notifier to hold and update the current value.
  final FeatureValueNotifier<T> notifier;

  // Initial value of the feature flag.
  final T _initialValue;

  // Constructor initializing the key and initial value.
  BaseFeatureFlag({
    required this.key,
    required T initialValue,
  })  : notifier = FeatureValueNotifier(initialValue),
        _initialValue = initialValue;

  // Getter for the current value.
  T get value => notifier.value;

  // Getter for the initial value
  T get initialValue => _initialValue;

  // Setter to update the value.
  set value(T newValue) {
    notifier.value = newValue;
  }

  // Resets the value to the initial value.
  void reset() {
    notifier.value = _initialValue;
  }

  // Adds a listener for value changes.
  void listen(ListenFeatureChangeCallback<T> callback) =>
      notifier.listen(callback);

  // Abstract method to sync value with Firebase Remote Config.
  void syncValue(RemoteConfigUpdater configUpdater);
}

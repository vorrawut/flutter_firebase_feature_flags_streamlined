import 'dart:async';
import 'package:flutter/foundation.dart';

typedef ListenFeatureChangeCallback<T> = Function(T value);

// Notifier class extending ValueNotifier to support streaming value changes.
class FeatureValueNotifier<T> extends ValueNotifier<T> {
  // Initializes the notifier with a value and adds it to the stream.
  FeatureValueNotifier(T value) : super(value) {
    _valueStream.add(value);
  }

  // StreamController to broadcast value changes.
  final _valueStream = StreamController<T>.broadcast();

  // Updates the value and adds it to the stream.
  @override
  set value(T newValue) {
    super.value = newValue;
    _valueStream.add(newValue);
  }

  // Disposes the stream controller and notifier.
  @override
  void dispose() {
    _valueStream.close();
    super.dispose();
  }

  // Adds a listener that triggers on value change.
  void listen(ListenFeatureChangeCallback<T> callback) {
    addListener(() => callback.call(value));
  }

  // Exposes the stream of value changes.
  Stream<T> get stream => _valueStream.stream;
}

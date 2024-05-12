import 'package:flutter/material.dart';

abstract class ConditionalWidget {
  static Widget single({
    required bool condition,
    required Widget widget,
    required Widget fallback,
  }) {
    if (condition) return widget;

    return fallback;
  }
}

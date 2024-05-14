import 'package:flutter/material.dart';

abstract class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String title,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(content: Text(title));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_shopping_flutter/utils/conditional_widget.dart';

void main() {
  group('conditional widget', () {
    test('condition true', () async {
      final result = ConditionalWidget.single(
        condition: true,
        widget: Container(),
        fallback: const SizedBox(),
      );

      expect(result, isA<Container>());
    });

    test('condition false', () async {
      final result = ConditionalWidget.single(
        condition: false,
        widget: Container(),
        fallback: const SizedBox(),
      );

      expect(result, isA<SizedBox>());
    });
  });
}

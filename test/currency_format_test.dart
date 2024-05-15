import 'package:flutter_test/flutter_test.dart';
import 'package:online_shopping_flutter/extensions/string_x.dart';

void main() {
  group('currency format', () {
    test('10000 => 10,000', () {
      final result = '10000'.currency;

      expect(result, '10,000.0');
    });
  });
}

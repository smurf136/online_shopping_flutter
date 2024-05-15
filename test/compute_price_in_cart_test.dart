import 'package:flutter_test/flutter_test.dart';
import 'package:online_shopping_flutter/domain/models/cart_model.dart';
import 'package:online_shopping_flutter/domain/models/product_model.dart';
import 'package:online_shopping_flutter/presentation/common/widgets/cart_tab_content.dart';

void main() {
  group('compute price in cart', () {
    test('one product', () {
      final data = {
        '1': CartModel(
          product: ProductModel(
            id: "1",
            name: "T-Bone Slice 300g.",
            imageUrl: "https://images.unsplash.com/photo-1551028150-64b9f398f678?fit=crop&w=200&q=200",
            price: 250,
          ),
          amount: 4,
        ),
      };
      final result = const CartTabContent().computePrice(currentCart: data);

      expect(result, 1000);
    });
    test('two product', () {
      final data = {
        '1': CartModel(
          product: ProductModel(
            id: "1",
            name: "T-Bone Slice 300g.",
            imageUrl: "https://images.unsplash.com/photo-1551028150-64b9f398f678?fit=crop&w=200&q=200",
            price: 250,
          ),
          amount: 4,
        ),
        '2': CartModel(
          product: ProductModel(
            id: "2",
            name: "Eggs No.1 Pack 30",
            imageUrl: "https://images.unsplash.com/photo-1516448620398-c5f44bf9f441?fit=crop&w=200&q=200",
            price: 149,
          ),
          amount: 8,
        ),
      };
      final result = const CartTabContent().computePrice(currentCart: data);

      expect(result, 2192);
    });
  });
}

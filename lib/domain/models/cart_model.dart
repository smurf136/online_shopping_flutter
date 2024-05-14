import 'product_model.dart';

class CartModel {
  CartModel({
    required this.product,
    required this.amount,
  });

  final ProductModel product;
  final int amount;
}

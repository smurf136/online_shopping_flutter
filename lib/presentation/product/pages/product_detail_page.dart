import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/models/cart_model.dart';
import '../../../domain/models/product_model.dart';
import '../../../domain/states/cart_product_state_provider.dart';
import '../../common/widgets/custom_outline_button.dart';
import '../../common/widgets/custom_snackbar.dart';
import '../../common/widgets/saved_button.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.price,
  });

  final String id;
  final String productName;
  final String imageUrl;
  final double price;

  static const path = '/product_detail_page';

  static Future<void> show(
    BuildContext context, {
    required String id,
    required String productName,
    required String imageUrl,
    required double price,
  }) async {
    Navigator.pushNamed(context, '$path/$id', arguments: {
      'productName': productName,
      'imageUrl': imageUrl,
      'price': price,
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (_) {
        ScaffoldMessenger.of(context).clearSnackBars();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: CupertinoButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              Navigator.of(context).pop();
            },
            child: const FaIcon(FontAwesomeIcons.angleLeft),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                width: screenSize.width - 32,
                height: screenSize.width - 32,
                fit: BoxFit.cover,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                alignment: Alignment.centerRight,
                // save button
                child: SaveButton(
                  id: id,
                  imageUrl: imageUrl,
                  price: price,
                  productName: productName,
                ),
              ),
              Text(productName, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text('\$$price', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Consumer(
                builder: (context, ref, _) {
                  return CustomOutlineButton(
                    onPressed: () {
                      final _currentCart = ref.read(cartProductStateProvider);

                      if (_currentCart[id] != null) {
                        _currentCart[id] = CartModel(
                          amount: _currentCart[id]!.amount + 1,
                          product: _currentCart[id]!.product,
                        );
                      } else {
                        _currentCart[id] = CartModel(
                          amount: 1,
                          product: ProductModel(
                            id: id,
                            imageUrl: imageUrl,
                            name: productName,
                            price: price,
                          ),
                        );
                      }

                      ref.read(cartProductStateProvider.notifier).state = {..._currentCart};

                      CustomSnackbar.show(
                        context,
                        title: 'Add product to cart success! ${(_currentCart[id]?.amount ?? 0) > 0 ? 'current: ${_currentCart[id]!.amount}' : ''}',
                      );
                    },
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    title: 'Add to Cart',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

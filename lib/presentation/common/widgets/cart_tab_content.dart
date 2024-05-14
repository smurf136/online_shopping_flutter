import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/cart_model.dart';
import '../../../domain/states/cart_product_state_provider.dart';
import '../../../extensions/string_x.dart';
import '../../../utils/conditional_widget.dart';
import '../../payment/pages/payment_page.dart';
import 'cart_item.dart';
import 'custom_outline_button.dart';

class CartTabContent extends ConsumerWidget {
  const CartTabContent({super.key});

  double computePrice({required Map<String, CartModel> currentCart}) {
    var _price = 0.0;

    for (var e in currentCart.values) {
      _price += e.amount * e.product.price;
    }

    return _price;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProductStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Stack(
        children: [
          ConditionalWidget.single(
            condition: cart.keys.isEmpty,
            widget: const Center(child: Text('no product in cart')),
            fallback: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                children: List.generate(
                  cart.keys.length,
                  (index) {
                    final _productId = cart.keys.toList()[index];
                    return CartItem(
                      onDismissed: () {
                        final _map = {...cart};

                        _map.removeWhere((key, value) => key == _productId);

                        ref.read(cartProductStateProvider.notifier).state = {..._map};
                      },
                      id: _productId,
                      imageUrl: cart[_productId]?.product.imageUrl ?? '',
                      price: cart[_productId]?.product.price ?? 0,
                      productName: cart[_productId]?.product.name ?? '',
                    );
                  },
                ),
              ),
            ),
          ),
          ConditionalWidget.single(
            condition: cart.keys.isEmpty,
            widget: const SizedBox.shrink(),
            fallback: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Total: ',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                            ),
                            TextSpan(
                              text: '\$${computePrice(currentCart: cart).toString().currency}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomOutlineButton(
                      onPressed: () {
                        PaymentPage.show(context, price: computePrice(currentCart: cart));
                      },
                      title: 'Checkout',
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

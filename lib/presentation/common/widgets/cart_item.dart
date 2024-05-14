import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/models/cart_model.dart';
import '../../../domain/states/cart_product_state_provider.dart';
import '../../../extensions/string_x.dart';
import '../../product/pages/product_detail_page.dart';

class CartItem extends ConsumerWidget {
  const CartItem({
    super.key,
    required this.onDismissed,
    required this.id,
    required this.imageUrl,
    required this.productName,
    required this.price,
  });

  final VoidCallback onDismissed;
  final String id;
  final String imageUrl;
  final String productName;
  final double price;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () {
        ProductDetailPage.show(
          context,
          id: id,
          imageUrl: imageUrl,
          price: price,
          productName: productName,
        );
      },
      minSize: 0,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Slidable(
          key: UniqueKey(),
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const DrawerMotion(),
            dismissible: DismissiblePane(onDismissed: onDismissed),
            children: [
              SlidableAction(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                onPressed: (context) => onDismissed(),
                backgroundColor: Colors.red,
                icon: FontAwesomeIcons.trashCan,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\$${price.toString().currency} ', style: Theme.of(context).textTheme.labelLarge),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: _AdjustCartAmount(id: id),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AdjustCartAmount extends ConsumerWidget {
  const _AdjustCartAmount({
    required this.id,
  });

  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCart = ref.watch(cartProductStateProvider);

    return Container(
      height: 30,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        border: Border.all(color: Colors.grey[350]!),
      ),
      child: Row(
        children: [
          CupertinoButton(
            onPressed: () {
              final _map = {...currentCart};

              _map[id] = CartModel(
                amount: _map[id]!.amount + 1,
                product: _map[id]!.product,
              );

              ref.read(cartProductStateProvider.notifier).state = _map;
            },
            minSize: 30,
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
            child: const FaIcon(
              FontAwesomeIcons.plus,
              size: 12,
              color: Colors.black,
            ),
          ),
          VerticalDivider(
            color: Colors.grey[350],
            width: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Text(
              (currentCart[id]?.amount ?? 0).toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          VerticalDivider(
            color: Colors.grey[350],
            width: 1,
            thickness: 1,
          ),
          CupertinoButton(
            onPressed: () {
              if ((currentCart[id]?.amount ?? 0) < 2) return;

              final _map = {...currentCart};

              _map[id] = CartModel(
                amount: _map[id]!.amount - 1,
                product: _map[id]!.product,
              );

              ref.read(cartProductStateProvider.notifier).state = _map;
            },
            minSize: 30,
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
            child: FaIcon(
              FontAwesomeIcons.minus,
              size: 12,
              color: (currentCart[id]?.amount ?? 0) < 2 ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/models/product_model.dart';
import '../../../domain/states/saved_product_list_provider_state_provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.cardWidth,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.id,
  });

  final double cardWidth;
  final String imageUrl;
  final String productName;
  final double price;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: cardWidth,
            height: cardWidth,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: cardWidth,
                  height: cardWidth,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: _SaveButton(
                    id: id,
                    productName: productName,
                    imageUrl: imageUrl,
                    price: price,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
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
                  Text('$price \$', style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.price,
  });

  final String id;
  final String productName;
  final String imageUrl;
  final double price;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(savedProductListStateProvider).indexWhere((e) => e.id == id) > -1;

    return CupertinoButton(
      onPressed: () {
        final indexOfProduct = ref.read(savedProductListStateProvider).indexWhere((e) => e.id == id);
        final currentList = ref.read(savedProductListStateProvider);
        if (indexOfProduct > -1) {
          currentList.removeAt(indexOfProduct);
          ref.read(savedProductListStateProvider.notifier).state = [...currentList];
        } else {
          ref.read(savedProductListStateProvider.notifier).state = [
            ...currentList,
            ProductModel(
              id: id,
              name: productName,
              imageUrl: imageUrl,
              price: price,
            )
          ];
        }
      },
      minSize: 20,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: FaIcon(
        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        color: Colors.red,
      ),
    );
  }
}

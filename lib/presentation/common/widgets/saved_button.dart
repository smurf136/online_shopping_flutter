import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/models/product_model.dart';
import '../../../domain/states/saved_product_list_provider_state_provider.dart';

class SavedButton extends ConsumerWidget {
  const SavedButton({
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

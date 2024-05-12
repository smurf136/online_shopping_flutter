import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../product/pages/product_detail_page.dart';
import 'saved_button.dart';

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
                  child: SaveButton(
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

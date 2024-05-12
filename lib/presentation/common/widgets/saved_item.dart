import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/states/cart_product_state_provider.dart';

class SavedItem extends ConsumerWidget {
  const SavedItem({
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
    return Container(
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
                  height: 60,
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
              ),
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                alignment: Alignment.center,
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Consumer(
                  builder: (context, ref, _) {
                    final productInCartAmount = ref.watch(cartProductStateProvider);
                    return Text(
                      (productInCartAmount[id] ?? 0).toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

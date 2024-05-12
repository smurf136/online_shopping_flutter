import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/states/saved_product_list_provider_state_provider.dart';
import '../../../utils/conditional_widget.dart';
import 'saved_item.dart';

class SavedTabContent extends ConsumerWidget {
  const SavedTabContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedList = ref.watch(savedProductListStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: ConditionalWidget.single(
        condition: savedList.isEmpty,
        widget: const Center(child: Text('no product saved')),
        fallback: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: _RemoveAllSavedButton(),
              ),
              ...List.generate(
                savedList.length,
                (index) {
                  final _item = savedList[index];
                  return SavedItem(
                    onDismissed: () {
                      savedList.removeAt(index);
                      ref.read(savedProductListStateProvider.notifier).state = [...savedList];
                    },
                    id: _item.id,
                    imageUrl: _item.imageUrl,
                    productName: _item.name,
                    price: _item.price,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _RemoveAllSavedButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () {
        ref.read(savedProductListStateProvider.notifier).state = [];
      },
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      minSize: 0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.trashCan,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            'Remove all',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}

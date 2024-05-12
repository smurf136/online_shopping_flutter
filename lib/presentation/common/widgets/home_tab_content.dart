import 'package:flutter/material.dart';

import '../../../domain/models/product_model.dart';
import 'product_item.dart';

class HomeTabContent extends StatelessWidget {
  HomeTabContent({super.key});

  static const path = '/home_tab_content';

  final productList = [
    ProductModel(
      id: "1",
      name: "T-Bone Slice 300g.",
      imageUrl: "https://images.unsplash.com/photo-1551028150-64b9f398f678?fit=crop&w=200&q=200",
      price: 250,
    ),
    ProductModel(
      id: "2",
      name: "Eggs No.1 Pack 30",
      imageUrl: "https://images.unsplash.com/photo-1516448620398-c5f44bf9f441?fit=crop&w=200&q=200",
      price: 149,
    ),
    ProductModel(
      id: "3",
      name: "Frozen Atlantic Salmon 125g.",
      imageUrl: "https://images.unsplash.com/photo-1599084993091-1cb5c0721cc6?fit=crop&w=200&q=200",
      price: 98,
    ),
    ProductModel(
      id: "4",
      name: "White Prawn 30pcs per kg.",
      imageUrl: "https://images.unsplash.com/photo-1504309250229-4f08315f3b5c?fit=crop&w=200&q=200",
      price: 299,
    ),
    ProductModel(
      id: "5",
      name: "Broccoli 1kg.",
      imageUrl: "https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?fit=crop&w=200&q=200",
      price: 96,
    ),
    ProductModel(
      id: "6",
      name: "Caabbage 3kg.",
      imageUrl: "https://images.unsplash.com/photo-1611105637889-3afd7295bdbf?fit=crop&w=200&q=200",
      price: 129,
    ),
    ProductModel(
      id: "7",
      name: "Itambé natural milk 1L.",
      imageUrl: "https://images.unsplash.com/photo-1563636619-e9143da7973b?fit=crop&w=200&q=200",
      price: 79,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommendation',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: productList.length,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          mainAxisExtent: (screenWidth / 3) * 2,
        ),
        itemBuilder: (context, index) {
          final _item = productList[index];
          return LayoutBuilder(
            builder: (context, boxConstraint) {
              return ProductItem(
                cardWidth: boxConstraint.maxWidth,
                imageUrl: _item.imageUrl,
                productName: _item.name,
                price: _item.price,
                id: _item.id,
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../manager/product_manager.dart';
import 'product_card.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  const ProductsGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    
    final products = context.select<ProductManager, List<Product>>(
      (productsManager) => showFavorites 
        ? productsManager.favoriteItems 
        : productsManager.items
    );
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductCard(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1/1.275,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10
      ),
    );
  }
}
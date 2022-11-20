import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/cart_manager.dart';
import '../cart/cart_screen.dart';
import '../share/top_right_badge.dart';
import 'product_grid.dart';

enum FilterOptions { favorites, all }

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: const Color(0xFF0C9869),
        titleSpacing: 10,
        title: Text(
          (_showOnlyFavorites.value) ? 'Sản phẩm yêu thích' : 'Sản phẩm',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          buildProductFilterIcon(),
          buildShoppingCartIcon(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ValueListenableBuilder<bool>(
          valueListenable: _showOnlyFavorites,
          builder: (context, onlyFavorites, child){
            return ProductsGrid(onlyFavorites);
          }
        )
      ),
    );
  }

  Widget buildProductFilterIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          (_showOnlyFavorites.value) 
            ? _showOnlyFavorites.value = false
            : _showOnlyFavorites.value = true;
        });
      },
      icon: Icon(
        (_showOnlyFavorites.value) 
          ? Icons.favorite
          : Icons.favorite_border,
        size: 26,
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 26,
            ),
            onPressed: () {
              Navigator.of(ctx).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }
}

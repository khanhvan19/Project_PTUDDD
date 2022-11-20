import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../screens.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GridTile(
          child: Stack( children: [
            Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: product.id,
                  );
                },
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Text(product.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1,
                      fontWeight: FontWeight.w600
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: Text('${product.price}đ',
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),    
            ]),
            Positioned(
              top: 0,
              right: 0,
              child: buildFavoriteButtons(context),
            )
          ])
        ),
      ),
    );
  }

  Widget buildFavoriteButtons(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: product.isFavoriteListenable,
      builder: (ctx, isFavorite, child) {
        return IconButton(
          onPressed: () {
            ctx.read<ProductManager>().toggleFavoriteStatus(product);
          },
          icon: Icon (
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 28,
            color: (isFavorite) ? Colors.deepOrange : Colors.white,
          ),
        );
      },
    );
  }
}


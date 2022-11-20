import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../manager/product_manager.dart';
import '../../manager/cart_manager.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen( this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: Text(product.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        titleSpacing: 10,
        backgroundColor: const Color(0xFF0C9869),
      ),
      body: Column(children: [
        Expanded(
          child: Stack( children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                product.image,
                fit: BoxFit.cover
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                height: MediaQuery.of(context).size.height * 0.46,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                  )
                ),        
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title,
                      style: const TextStyle(
                        fontSize: 24,
                        height: 1.1,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text('${product.price}đ',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepOrange
                      ),
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(product.description,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        )
                      ) 
                    )
                  ]
                ),
              ),
            )
          ])
        ),
        buildDetailSummary(context)
      ])
    );
  }

  Widget buildDetailSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Color(0x4E0C9869),
            offset: Offset(0, -2),
          )
        ]
      ), 
      child: Row(children: [
        ValueListenableBuilder<bool>(
          valueListenable: product.isFavoriteListenable,
          builder: (ctx, isFavorite, child) {
            return GestureDetector(
              onTap: () {
                ctx.read<ProductManager>().toggleFavoriteStatus(product);
              },
              child: Icon (
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 50,
                color: Colors.deepOrange,
              ),
            );
          },
        ),
        const SizedBox(width: 25),
        Expanded(
          child: SizedBox(
            height: 55,
            child: TextButton(
              onPressed: () {
                final cart = context.read<CartManager>();
                cart.addItem(product);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: const Text('Thêm giỏ hàng thành công'),
                      ),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        textColor: Colors.green,
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(product.id!);
                        },
                      ),
                    ),
                  );
              },
              style: TextButton.styleFrom(
                elevation: 3,
                backgroundColor: Colors.deepOrange
              ),
              child: const Text('Thêm giỏ hàng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../share/dialog.dart';
import '../../manager/cart_manager.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cartItem;

  const CartItemCard({
    required this.productId,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Bạn muốn xóa sản phẩm này khỏi giỏ hàng?'
        );
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(productId);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(cartItem.image),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    cartItem.title,
                    style: const TextStyle(
                      height: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text('${cartItem.price}đ', style: const TextStyle(fontSize: 12)),
                ]),
              ),
              Text(
                'Tổng: ${cartItem.price * cartItem.quantity}đ',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF0C9869)
                ),
              )
            ]
          ),
        ),
        Center(
          child: Text('x ${cartItem.quantity}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ]),
    );
  }
}

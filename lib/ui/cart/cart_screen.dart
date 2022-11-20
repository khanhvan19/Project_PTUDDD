import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/cart_manager.dart';
import 'cart_item_card.dart';
import 'checkout_modal.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text('Giỏ hàng',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        titleSpacing: 10,
        backgroundColor: const Color(0xFF0C9869),
      ),
      body: Column( children: [
        Expanded(
          child: buildCartDetails(cart)
        ),
        buildCartSummary(cart, context),
      ]),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: cart.productEntries.map(
        (entry) => CartItemCard(
          productId: entry.key,
          cartItem: entry.value,
        ),
      ).toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Color(0x4E0C9869),
            offset: Offset(0, -2),
          )
        ]
      ), 
      child: Column(children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Thanh toán:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${cart.totalAmount} đ',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              )
            ]
          ),
        ),
        ElevatedButton(
          onPressed: cart.totalAmount <= 0 
            ? null
            :() {
              // context.read<OrdersManager>().addOrder();
              // cart.clear();
              _showModalCheckout(context);
            },
          style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: Colors.deepOrange,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35)
            )
          ),
          child: Text(
            'Đặt hàng (${cart.productTotalCount})',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ]),
    );
  }

  void _showModalCheckout(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        )
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.89,
        maxChildSize: 0.89,
        minChildSize: 0.2,
        builder: (context, scrollController) => 
          SingleChildScrollView(
            controller: scrollController,
            child: const CheckoutModal(),
          ),
      )
    );
  }
}

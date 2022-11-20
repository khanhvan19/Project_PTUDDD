import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/order_manager.dart';
import './order_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  Future<void> _refreshOrders(BuildContext context) async{
    await context.read<OrdersManager>().fetchOrders(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text('Đơn hàng đã đặt',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        titleSpacing: 10,
        backgroundColor: const Color(0xFF0C9869),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FutureBuilder(
          future: _refreshOrders(context),
          builder: (ctx,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh:() => _refreshOrders(context),
              child: buildOrderstListView(),
            );
          },
        ),
      ),
    );
  }

  Widget buildOrderstListView() {
    return Consumer<OrdersManager>(
      builder: (ctx, ordersManager, child) {
        return ListView.builder(
          itemCount: ordersManager.orderCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              OrderCard(
                ordersManager.orders[i]
              ),
            ],
          ),
        );
      },
    );
  }
}
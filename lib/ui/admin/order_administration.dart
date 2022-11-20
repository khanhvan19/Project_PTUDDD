import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/order_manager.dart';
import '../order/order_card.dart';

import '../share/admin_drawer.dart';

class OrderAdministration extends StatelessWidget {
  static const routeName = '/admin_orders';
  const OrderAdministration({super.key});

  Future<void> _fetchOrders(BuildContext context) async{
    await context.read<OrdersManager>().fetchOrders(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text('Quản lý đơn hàng',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        titleSpacing: 10,
        backgroundColor: Colors.blue,
      ),
      drawer: const AdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FutureBuilder(
          future: _fetchOrders(context),
          builder: (ctx,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return buildOrderstListView();
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
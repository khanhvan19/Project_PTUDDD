import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/product_manager.dart';
import './edit_product_screen.dart';
import './product_administration_card.dart';
import '../share/admin_drawer.dart';

class ProductAdministration extends StatelessWidget {
  static const routeName = '/admin_product';
  const ProductAdministration({super.key});

  Future<void> _refreshProducts(BuildContext context) async{
    await context.read<ProductManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        titleSpacing: 10,
        backgroundColor: Colors.blue,
        title: const Text('Quản lý sản phẩm',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AdminDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh:() => _refreshProducts(context),
            child: buildProductAdminListView(),
          );
        }
      ),
    );  
  }

  Widget buildProductAdminListView() {
    return Consumer<ProductManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductAdministrationCard(productsManager.items[i]),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }

}
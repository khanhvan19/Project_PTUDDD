import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../manager/product_manager.dart';
import './edit_product_screen.dart';


class ProductAdministrationCard extends StatelessWidget{
  final Product product;

  const ProductAdministrationCard(
    this.product, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: AssetImage(product.image),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        context.read<ProductManager>().deleteProduct(product.id!);
        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Product deleted',
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
      color: Theme.of(context).errorColor,
    );
  }

  Widget buildEditButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
          arguments: product.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }
}
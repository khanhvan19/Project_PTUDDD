// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ui/screens.dart';

Future<void> main() async{
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, ProductManager>(
          create: (ctx) => ProductManager(),
          update: (ctx, authManager, productsManager) {
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => CartManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, OrdersManager>(
          create: (ctx) => OrdersManager(),
          update: (ctx, authManager, ordersManager) {
            ordersManager!.authToken = authManager.authToken;
            return ordersManager; 
          },
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (context, authManager, child) {
          return MaterialApp (
            debugShowCheckedModeBanner: false,
            title: 'MilkTea',
            theme: ThemeData(
              fontFamily: 'Nunito',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.green,
              )
            ),
            home: (authManager.isAuth)
              ? (
                (context.read<AuthManager>().authToken!.email=='admin@admin.com') 
                  ? const ProductAdministration()
                  : const BottomBarScreen()
                ) 
              : FutureBuilder(
                future: authManager.tryAutoLogin(),
                builder: ((context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting 
                    ? const SplashScreen() 
                    : const Login();
                }),
              ),
            routes: {
              CartScreen.routeName: (ctx) => const CartScreen(),
              ProductAdministration.routeName: (ctx) => const ProductAdministration(),
              OrderAdministration.routeName: (ctx) => const OrderAdministration(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return ProductDetailScreen(
                      ctx.read<ProductManager>().findById(productId),
                    );
                  },
                );
              }

              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditProductScreen(
                      productId != null
                      ? ctx.read<ProductManager>().findById(productId)
                      : null,
                    );
                  },
                );
              }

              return null;
            },
          );
        }
      )
    );    
  }
}

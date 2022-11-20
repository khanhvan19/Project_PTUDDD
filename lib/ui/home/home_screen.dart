// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/product_manager.dart';
import '../product/product_card.dart';

import 'slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchProducts;
  
  final banners = [
    'assets/images/banner/banner1.png'
    'assets/images/banner/banner2.png',
    'assets/images/banner/banner3.png',
    'assets/images/banner/banner4.png'
  ];

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductManager>().fetchProducts();
  }
  
  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductManager>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Color(0xFF0C9869),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 225,
            margin: EdgeInsets.only(bottom: 30),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFF0C9869),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.0),
                      bottomRight: Radius.circular(35.0),
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row( children: const [
                          CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            radius: 30,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/avt.png'),
                              radius: 25,
                            )
                          ),
                          SizedBox(width: 10),
                          Text("Hi! Friend",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Text("Cùng đón một ngày thú vị với trà sữa tại Cat MilkTea nhé!",
                          style: TextStyle(
                            height: 1.25,
                            color: Colors.pink[100],
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15, top: 2),
                        child: Text("-- Meow 😻 --",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ), 
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [ 
                        BoxShadow(
                          blurRadius: 30,
                          spreadRadius: 15,
                          color: Color(0x4E0C9869)
                        )
                      ]
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 20, color: Color(0xFF0C9869)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        hintText: "Search...",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Icon(Icons.search, size: 30),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliderBanner(),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gợi ý riêng cho bạn:",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0C9869)
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 30),
                  height: 200,
                  child: FutureBuilder(
                    future: _fetchProducts,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            for(var i=0; i < 10; i++) 
                              SizedBox(
                                width: 150,
                                child: ProductCard(product.randomItems[i]),
                              )
                          ]
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ) 
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}
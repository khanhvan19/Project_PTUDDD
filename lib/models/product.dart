import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String title;
  final int price;
  final String image;
  final String description;
  final ValueNotifier<bool> _isFavorite;

  Product({
    this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }
  
  Product copyWith({
    String? id,
    String? title,
    int? price,
    String? image,
    String? description,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'description':description,
      'price':price,
      'image':image,
    };
  }
  static Product fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }

}
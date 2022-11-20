class CartItem {
  final String id;
  final String title;
  final String image;
  final int quantity;
  final int price;

  CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? title,
    String? image,
    int? quantity,
    int? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}

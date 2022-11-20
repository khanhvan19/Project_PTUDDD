class OrderItem {
  final String? id;
  final int amount;
  // final List<CartItem> products;
  final String dateTime;
  final String payer;
  final String address;
  final String phone;

  // int get productCount {
  //   return products.length;
  // }
  
  OrderItem({
    this.id,
    required this.amount,
    // this.products,
    required this.payer,
    required this.address,
    required this.phone,
    String? dateTime,
  }) : dateTime = dateTime ?? DateTime.now().toString();

  OrderItem copyWith({
    String? id,
    int? amount,
    // List<CartItem>? products,
    String? dateTime,
    String? payer,
    String? address,
    String? phone,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      // products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
      payer: payer ?? this.payer,
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'dateTime': dateTime,
      'payer': payer,
      'address': address,
      'phone': phone,
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      dateTime: json['dateTime'],
      payer: json['payer'],
      address: json['address'],
      phone: json['phone']
    );
  }


}


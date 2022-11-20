import 'package:flutter/material.dart';

import '../../models/order_item.dart';

class OrderCard extends StatefulWidget {
  const OrderCard(this.order, {super.key});

  final OrderItem order;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          if (_expanded) const Divider(),
          if (_expanded) buildOrderDetails()
        ],
      ),
    );
  }

  Widget buildOrderDetails() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(30, 3, 0, 3),
      height: 70,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Người nhận: ${widget.order.payer}'),
            Text('Số điện thoại: ${widget.order.phone}'),
            Text('Địa chỉ: ${widget.order.address}'),
          ]
        ),
      ),
    );
  }

  Widget buildOrderSummary() {
    return ListTile(
      title: Text('${widget.order.amount}đ'),
      subtitle: Text(
        widget.order.dateTime.split(".")[0]
      ),
      trailing: IconButton(
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
      ),
    );
  }
}
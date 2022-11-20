import 'package:flutter/material.dart';
import 'package:milk_tea/ui/share/dialog.dart';
import 'package:provider/provider.dart';

import '../../models/order_item.dart';
import '../../manager/order_manager.dart';
import '../../manager/cart_manager.dart';


class CheckoutModal extends StatefulWidget {
  const CheckoutModal({super.key});
  
  @override
  State<CheckoutModal> createState() => _CheckoutModalState();
}

class _CheckoutModalState extends State<CheckoutModal> {
  final _orderForm = GlobalKey<FormState>();
  late OrderItem _orderItem;

  @override 
  void initState() {
    _orderItem = OrderItem(
      amount: 0, 
      payer: '', 
      address: '', 
      phone: ''
    );
    super.initState();
  }

  var _isSubmited = false;

  Future<void> _submit() async {
    if(!_orderForm.currentState!.validate()) {
      return;
    }
    _orderForm.currentState!.save();
    setState(() {_isSubmited = true;});

    try {
      final ordersManager = context.read<OrdersManager>();
      final cartManager = context.read<CartManager>();
      await ordersManager.addOrder(_orderItem);
      cartManager.clear();
      
    } catch (error) {
      await showErrorDialog(context, 'Không thể đặt hàng lúc này');
    }

  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    _orderItem = _orderItem.copyWith(amount: cart.totalAmount);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: _isSubmited
        ? Column(children: const [
          Icon(Icons.check_circle_outline,
            size: 60,
            color: Color(0xFF0C9869),
          ),
          SizedBox(height: 20),
          Text('Đặt hàng thành công',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0C9869)
            ),
          ),
          Text('Đơn hàng sẽ được giao đến bạn nhanh nhất có thể.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ])
        : Form(
          key: _orderForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Thanh toán:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${cart.totalAmount} đ',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ]
              ),
              const SizedBox(height: 10,),
              const Text('Thông tin đặt hàng:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ) ,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    _buildPayerField(),
                    _buildPhoneField(),
                    _buildAddressField(),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              _buildSubmitButton(),
            ]
          ),
      ),
    );
  }

  Widget _buildPayerField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Tên người nhận:'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Vui lòng nhập tên người nhận.';
        }
        return null;
      },
      onSaved: (value) {
        _orderItem = _orderItem.copyWith(payer: value);
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Số điện thoại:'),
      textInputAction: TextInputAction.next,
      validator: (value) {
        RegExp regExp = RegExp(r'(^(?:[0])?[0-9]{9}$)');
        if(value!.isEmpty) {
          return 'Vui lòng nhập số điện thoại.';
        }
        if(!regExp.hasMatch(value)){
          return 'Số điện thoại không hợp lệ';
        }
        return null;
      },
      onSaved: (value) {
        _orderItem = _orderItem.copyWith(phone: value);
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Địa chỉ:'),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Vui lòng nhập địa chỉ.';
        }
        return null;
      },
      onSaved: (value) {
        _orderItem = _orderItem.copyWith(address: value);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: Colors.deepOrange,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35)
        )
      ),
      child: const Text(
        'Thanh toán',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
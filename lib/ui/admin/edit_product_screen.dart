import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../share/dialog.dart';

import '../../manager/product_manager.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    if (product == null) {
      this.product = Product(
        id: null,
        title: '',
        price: 0,
        description: '',
        image: '',
      );
    } else {
      this.product = product;
    }
  }

  late final Product product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Product _editedProduct;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return value.startsWith('assets/images/trasua') 
      && (value.endsWith('.png') 
        || value.endsWith('.jpg')
        || value.endsWith('jpeg'));
  }

  @override
  void initState() {
    _imageFocusNode.addListener(() {
      if (!_imageFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedProduct = widget.product;
    _imageController.text = _editedProduct.image;
    super.initState();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid  = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final productsManager = context.read<ProductManager>();
      if (_editedProduct.id != null) {
        await productsManager.updateProduct(_editedProduct);
      } else {
        await productsManager.addProduct(_editedProduct);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong.');
    }

    setState(() {
      _isLoading = false;
    });

    if(mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        titleSpacing: 10,
        backgroundColor: Colors.blue,
        title: Text((_editedProduct.id != null) ? 'Thêm sản phẩm': 'Chỉnh sửa sản phẩm',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _editForm,
              child: ListView(
                children: <Widget>[
                  buildTitleField(),
                  buildPriceField(),
                  buildDescriptionField(),
                  buildProductPreview(),
                ],
              ),
            ),
          ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.title,
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Please enter a title.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(title: value);
      },
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedProduct.price.toString(),
      decoration: const InputDecoration(labelText: 'Price'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Please enter a price.' ;
        }
        if(double.tryParse(value) == null) {
          return 'Please enter valid number.';
        }
        if(double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: int.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.description,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Please enter a description.';
        }
        if(value.length < 10) {
          return 'Should be at least 10 characters long';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(description: value);
      },
    );
  }

  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageController.text.isEmpty
            ? const Text('Enter a image')
            : FittedBox(
              child: Image.asset(
                _imageController.text,
                fit: BoxFit.cover,
              ),
            ),
        ),
        Expanded(
          child: buildImageURLField()
        ),  
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageController,
      focusNode: _imageFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(image: value);
      },
    );
  }
}

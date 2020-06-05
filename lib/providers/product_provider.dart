import 'package:flutter/material.dart';
import 'package:firestore_crud/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:firestore_crud/models/product.dart';

class ProductProvider with ChangeNotifier{
  final firestoreService = FirestoreService();

  //we will want to pretty much mirror the properties that we have in our model
  //we want private variables for each oene of those
  String _name;
  double _price;
  String _productId;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  double get price => _price;

  //Setters
  changeName(String value){
    _name = value;
    notifyListeners();
  }

  //Setters
  changePrice(String value){
    _price = double.parse(value);
    notifyListeners();
  }

  //digunakan di initstate edit_product.dart
  //gunanya agar si product_notifier tau kalo dia lagi update data buka add data
  //soalnya nyimpen nilai2nya dulu
  loadValues(Product product){
    _name = product.name;
    _price = product.price;
    _productId = product.productId;
  }

  saveProduct(){
    print(_productId);
    if(_productId == null){
      //add
      var newProduct = Product(name: name, price: price, productId: uuid.v4());
      firestoreService.saveProduct(newProduct);
    } else {
      //update
      var updatedProduct = Product(name: name, price: _price, productId: _productId);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  removeProduct(String productId){
    firestoreService.removeProduct(productId);
  }

}
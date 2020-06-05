import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_crud/models/product.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  //dijalankan ketika user menyimpan perubahan di edit_product.dart
  //melalui method saveProduct di product_provider.dart
  Future<void> saveProduct(Product product) {
    //jika .productId exist maka dia akan update, jika doesnt exist maka dia akan add
    return _db
        .collection('products')
        .document(product.productId)
        .setData(product.toMap());
  }

  //menampilkan list product di products.dart
  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Product.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeProduct(String productId){
    return _db.collection('products').document(productId).delete();
  }

}

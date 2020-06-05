class Product {
  final String productId;
  final String name;
  final double price;

  Product({this.productId, this.price, this.name});

  //turn our object into map, gunanya agar bisa setData ke firestore
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
    };
  }

  //to implement Stream getProducts in firestore_service.dart
  Product.fromFirestore(Map<String, dynamic> firestore)
    : productId = firestore['productId'],
      name = firestore['name'], 
      price = firestore['price'];
}

import 'package:firestore_crud/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firestore_crud/providers/product_provider.dart';
import 'services/firestore_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        StreamProvider(create: (context) => firestoreService.getProducts(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Products(),
      ),
    );
  }
}

import 'package:firestore_crud/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firestore_crud/providers/product_provider.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  EditProduct({this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  //called when this object is removed from the tree permanently
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  //called when this object is inserted into the tree
  @override
  void initState() {
    if (widget.product == null) {
      ///new record
      //controller update
      nameController.text = "";
      priceController.text = "";
      //cstate update
      new Future.delayed(Duration.zero, () {
        //kita pake delay karena sebenere ngga ada context yang kita pass ke provider (little bit hacky trick)
        final productProvider = Provider.of<ProductProvider>(context,
            listen:
                false); //kalo ngga di listen: false jd error, karena initstate cuma dipanggil sekali
        productProvider.loadValues(Product());
      });
    } else {
      ///existing record
      //controller update
      nameController.text = widget.product.name;
      priceController.text = widget.product.price.toString();
      //state update
      new Future.delayed(Duration.zero, () {
        //kita pake delay karena sebenere ngga ada context yang kita pass ke provider (little bit hacky trick)
        final productProvider = Provider.of<ProductProvider>(context,
            listen:
                false); //kalo ngga di listen: false jd error, karena initstate cuma dipanggil sekali
        productProvider.loadValues(widget.product);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Product Name'),
              onChanged: (value) {
                productProvider.changeName(value);
              },
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'Product Price'),
              onChanged: (value) => productProvider.changePrice(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                productProvider.saveProduct();
                Navigator.of(context).pop();
              },
            ),
            (widget.product != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete'),
                    onPressed: () {
                      productProvider.removeProduct(widget.product.productId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

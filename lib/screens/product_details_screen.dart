import 'package:flutter/material.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String title;
  // final double price;
  // const ProductDetailsScreen({Key? key,required this.title,required this.price}) : super(key: key);
  static const routName = '/product-details';

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;

    final loadedProduct = Provider.of<Products>(context,listen: false)
        .findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
            child: Image.network(loadedProduct.imageUrl,fit: BoxFit.cover),
            ),


            SizedBox(height: 10,),
            Text('\$${loadedProduct.price}',style: TextStyle(color: Colors.grey,fontSize: 20),)

           , SizedBox(height: 10,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(loadedProduct.description,textAlign: TextAlign.center,softWrap: true,

              ),
            )
          ],
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:state_management/providers/product.dart';
import 'package:state_management/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/Cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // const ProductItem(
  //     {Key? key, required this.id, required this.title, required this.imageUrl})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    return
           ClipRRect(
             borderRadius: BorderRadius.circular(8.0),
             child: GridTile(
               child: GestureDetector(
                 onTap: () {
                   Navigator.of(context).pushNamed(
                     ProductDetailsScreen.routName,
                     arguments: product.id,
                   );
                 },
                 child: Image.network(
                   product.imageUrl,
                   fit: BoxFit.cover,
                 ),
               ),
               footer: GridTileBar(
                   leading:

                   Consumer<Product>(
                       builder: (ctx,product,child) =>
                   IconButton(
                     color: Theme.of(context).accentColor,
                     icon: Icon(
                         product.isFavorite ? Icons.favorite : Icons.favorite_border),
                     onPressed: () {
                       product.toggleFavoriteStatus();
                     },
                   ),
                   ),
                   trailing: IconButton(
                     color: Theme.of(context).accentColor,
                     icon: const Icon(Icons.shopping_cart),
                     onPressed: () {
                       cart.addItems(product.id, product.price, product.title);
                       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         content: const Text('Added item to cart'),
                         duration: const Duration(seconds: 2),
                         action: SnackBarAction(
                           label: 'UNDO',
                           onPressed: () {
                              cart.removeSingleItem(product.id);
                           },
                         ),
                       ));
                     },
                   ),
                   backgroundColor: Colors.black87,
                   title: Text(
                     product.title,
                     textAlign: TextAlign.center,
                   )),
             ),
           );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/Cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItemWidget(
      {Key? key,
      required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    child: Text("\$${price}"),
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text("Total: \$${price * quantity}"),
              trailing: Text("$quantity x"),
            )),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                "Are you sure?",
              ),
              content: Text("Do you want to remove item from the cart?"),
              actions: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop(false);
                }, child: Text("No")),
                TextButton(onPressed: () {
                  Navigator.of(context).pop(true);
                }, child: Text("Yes")),
              ],
            );
          },
        );
      },
    );
  }
}

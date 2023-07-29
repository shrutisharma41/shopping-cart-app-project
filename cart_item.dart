import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantitiy;
  CartItem(this.id,this.productId,this.title,this.price,this.quantitiy,);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child:Icon(
          Icons.delete,
          color: Colors.white,
          size:40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ) ,
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
       return  showDialog(
          context: context, 
          builder:(ctx)=> AlertDialog(
            title: Text('Are u Sure?'),
            content: Text(
              'Do you want to remove item from cart?',
            ),
            actions:<Widget> [
              TextButton(
                child: Text('No'),
                onPressed:(){
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed:(){
                   Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
          );
     Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListTile(
            leading: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(child: CircleAvatar(child:Text('\₹$price'),
              ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total:\₹${(price*quantitiy)}'),
          ),
        ),
      ),
    );
  }
}
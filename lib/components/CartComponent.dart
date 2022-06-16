import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zartek/providers/CartProvider.dart';

class CartComponent extends StatefulWidget {

  String? dishid;
  String? id;
  int? quantity;
  double? price;
  String? name;
  int? calories;

  CartComponent({this.dishid,this.id,this.quantity,this.price,this.name,this.calories});
  @override
  _CartComponentState createState() => _CartComponentState();
}

class _CartComponentState extends State<CartComponent> {
  @override
  Widget build(BuildContext context) {
    final cartprovider =Provider.of<CartProvider>(context);

    var cart = cartprovider.cart;

    int cartlength = cartprovider.itemcount;

    int totq=cartprovider.totalquantity;


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2.9,
                    child: Text(widget.name.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14.0),)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 3.0),
                  height: 35.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.green[900]
                  ),
                  child: Row(
                    children: [
                      IconButton(icon: FaIcon(FontAwesomeIcons.minus,color: Colors.white,size: 15.0,),
                        onPressed: (){
                          cartprovider.removefromcart(widget.dishid.toString(), widget.name.toString(),widget.price!.toDouble(),widget.calories!.toDouble());
                        }
                        ,),

                      Text(widget.quantity.toString(),style: TextStyle(color: Colors.white),),
                      Expanded(
                        child: IconButton(icon: FaIcon(FontAwesomeIcons.plus,color: Colors.white,size: 15.0,),
                          onPressed: (){
                            print("cart item id");
                            print(widget.dishid.toString());

                            cartprovider.addtocart(widget.dishid.toString(), widget.name.toString(),widget.price!.toDouble(),widget.calories!.toDouble());
                          }
                          ,),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 2.0,),
                Text('INR '+(widget.quantity!*widget.price!.toDouble()).toStringAsFixed(1),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14.0),)

              ],
            ),
            SizedBox(height: 3.0,),

            Text('INR '+(widget.price!.toDouble()).toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14.0),),
            SizedBox(height: 5.0,),

            Text((widget.calories!.toInt()*widget.quantity!.toInt()).toString()+" Calories",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14.0),),

            SizedBox(height: 15.0,),
            Divider(height: 2.0,color: Colors.black,),



          ],
        ),
      ),
    );;
  }

}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek/components/CartComponent.dart';
import 'package:zartek/providers/CartProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zartek/screens/HomePage.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override

  Widget build(BuildContext context) {
    final cartprovider =Provider.of<CartProvider>(context,listen: true);

    var cart = cartprovider.cart;

    int cartlength = cartprovider.itemcount;

    int totq=cartprovider.totalquantity;

    double amount = cartprovider.totalamount;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Order Summary',style: TextStyle(color: Colors.black,fontSize: 15.0),),
        leading: BackButton(color: Colors.black,onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        },),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(

            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: Colors.grey)
            ),
            padding: EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white38,

              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green[900]
                    ),
                    child: cartlength==0?Center(child: Text("Your Cart is empty",style: TextStyle(color: Colors.white,fontSize: 15.0),)):
                    Center(
                      child: Text(cartlength.toString()+" Dishes "+totq.toString()+" Items",style: TextStyle(color: Colors.white,fontSize: 15.0),
                  ),
                    ),
                  ),

                 cartlength!=0? Container(
                   height: 140*cartlength.toDouble(),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartlength,
                        itemBuilder: (BuildContext context,index){
                      return CartComponent(dishid: cart.values.toList()[index].dishid.toString(),
                        id: cart.values.toList()[index].id.toString(),
                        name: cart.values.toList()[index].name.toString(),
                        quantity: cart.values.toList()[index].quantity,
                        price: cart.values.toList()[index].price!.toDouble(),
                        calories: cart.values.toList()[index].calories!.toInt(),
                      );

                    }),
                  ):Container(height: 20.0,width: 100.0,color: Colors.white,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18.0),),
                      Text('INR '+amount.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0,color: Colors.green),)

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {

                  cartprovider.emptycart();
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: new Text("Alert"),
                    content: new Text(
                      "Order Placed",
                      textAlign: TextAlign.center,
                      style: TextStyle(

                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text(
                          "Close",
                          style: TextStyle(
                              color: Colors.green[900]),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage()));
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text('Place Order',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18.0),)),
              decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.circular(30.0)
              ),
            ),
          ),
        ),
      ),
    );
  }


}


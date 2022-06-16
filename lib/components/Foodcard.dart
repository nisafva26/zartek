import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zartek/class/ResturantClass.dart';
import 'package:provider/provider.dart';
import 'package:zartek/providers/CartProvider.dart';

class FoodCard extends StatefulWidget {

  List<CategoryDish>? catdishes;
  int? quantity;
  FoodCard({this.catdishes,this.quantity});
  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {

  var details = new Map();

  /*widget.catdishes!.forEach((element) {
  details[element.dishId]=0;
  });

   */





//  int quantity =0;
  @override




  Widget build(BuildContext context) {







    print(widget.catdishes![0].dishImage);

    final cartprovider =Provider.of<CartProvider>(context);

    var cart = cartprovider.cart;

    return ListView.builder(
      itemCount: widget.catdishes!.length,
        itemBuilder: (BuildContext context,int index){
        return Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.5,
                    child: Column(
                     // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.catdishes![index].dishName.toString(),style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('INR '+widget.catdishes![index].dishPrice.toString(),style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w500),),
                            Text(widget.catdishes![index].dishCalories.toString()+' calories',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w500),),
                          ],
                        ),

                      ],
                    ),
                  ),

                  Container(
                    width: 80.0,height: 100.0,

                    decoration: BoxDecoration(
                      image: DecorationImage(image:NetworkImage('https://hips.hearstapps.com/hmg-prod/images/spinachsaladhorizontal-jpg-1592245758.jpg') as ImageProvider )
                    ),
                  )

                ],
              ),
             // SizedBox(height: 5.0,),
              Text(widget.catdishes![index].dishDescription.toString(),style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w400,color: Colors.black38),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 3.0),
                height: 35.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.green
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    IconButton(icon: FaIcon(FontAwesomeIcons.minus,color: Colors.white,size: 15.0,),
                    onPressed: (){

                        setState(() {

                          widget.catdishes![index].quantity=widget.catdishes![index].quantity!-1;
                        });
                        cartprovider.removefromcart(widget.catdishes![index].dishId.toString(), widget.catdishes![index].dishName.toString(), widget.catdishes![index].dishPrice!.toDouble(),widget.catdishes![index].dishCalories!.toDouble());

                    },),
                    cart.containsKey(widget.catdishes![index].dishId.toString())?Text(cart[widget.catdishes![index].dishId.toString()]!.quantity.toString(),style: TextStyle(color: Colors.white,fontSize: 15.0),):
                    Text('0',style: TextStyle(color: Colors.white,fontSize: 15.0)),

                    Expanded(
                      child: IconButton(icon: FaIcon(FontAwesomeIcons.plus,color: Colors.white,size: 15.0,),
                        onPressed: (){
                        print("calories:");

                          print(widget.catdishes![index].dishCalories!.toInt());

                          setState(() {
                            widget.catdishes![index].quantity=widget.catdishes![index].quantity!+1;
                          });


                          cartprovider.addtocart(widget.catdishes![index].dishId.toString(), widget.catdishes![index].dishName.toString(), widget.catdishes![index].dishPrice!.toDouble(),widget.catdishes![index].dishCalories!.toDouble());



                        },),
                    ),
                  ],
                ),
              ),
          SizedBox(height: 10.0,),
          if(widget.catdishes![index].addonCat!.isNotEmpty)
              Text('Customizations available',style: TextStyle(color: Colors.red),),
              SizedBox(height: 5.0,),
              Divider(color: Colors.black,)
            ],
          ),
        );
    }
    );
  }

}

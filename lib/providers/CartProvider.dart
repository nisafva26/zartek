import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zartek/class/Cart.dart';

class CartProvider with ChangeNotifier{


  Map<String,Cart> _cart={};

  Map<String,Cart> get cart {
    return {..._cart};
  }

  int get itemcount{

    return _cart.length;

  }

  void emptycart(){
    _cart.clear();
    notifyListeners();
  }

  int get totalquantity{

    int total=0;

    _cart.forEach((key, value) {
      total+=value.quantity!.toInt();
    });
    return total;
  }

  double get totalamount{

    double total=0;

    _cart.forEach((key, value) {
      total+=value.quantity!*value.price!.toDouble();
    });
    return total;
  }


  
  
  void addtocart(String id,String name,double price,double calories){

    if(_cart.containsKey(id)){

      print(id+" already exists");
      print(_cart[id]!.quantity!.toString());
      print(_cart[id]!.calories!.toString());


      _cart.update(id, (value) => Cart(
        id: value.id,
        name: value.name,
        quantity: value.quantity!+1,
        price: value.price,
        dishid: value.dishid,
        calories: calories

      ));
      print("adding count");
      print(_cart[id]!.quantity);

    }else{

      print(id+" not exist");
      print("adding product");


      _cart.putIfAbsent(id, () => Cart(
        id: DateTime.now().toString(),
        price: price,
        quantity: 1,
        name: name,
        dishid: id,
          calories: calories
      ));


    }
    notifyListeners();
  }

  void removefromcart(String id,String name,double price,double calories){

    print("cart lenght ");

    print(_cart.length);

    print(_cart[id]!.dishid!.toString());
    print(_cart[id]!.quantity!.toString());

    if(_cart.containsKey(id)){

      print(id+" already exists");
      print(_cart[id]!.quantity!.toString());

      _cart.update(id, (value) => Cart(
        id: value.id,
        price: value.price,
        quantity: value.quantity!-1,
        name: value.name,
        dishid: id,
        calories: calories

      ));
      print("reducing count");
      print(_cart[id]!.quantity);

      if(_cart[id]!.quantity==0){

        print("removing cart id ");
        _cart.remove(id);
      }
    }else{

      print("cart not containes id");
    }
    notifyListeners();




  }
  
  


}
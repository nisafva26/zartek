import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zartek/class/ResturantClass.dart';
import 'package:zartek/components/Foodcard.dart';
import 'package:zartek/providers/CartProvider.dart';
import 'package:zartek/providers/CategoryProvider.dart';
import 'package:zartek/screens/cartscreen.dart';
import 'package:zartek/screens/signin.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isinit = true;
  bool _isloaded = false;

  bool _iscomplete = false;
  List<Restuarant>? rest;

  @override
  void initState() {
    super.initState();
  }

  /* getdata() async{
    rest = await Provider.of<CategoryProvider>(context).getcategory();

    print("restuarant");
    print(rest);
  }

  */

  @override
  void didChangeDependencies() async {
    if (_isinit) {
      rest = await Provider.of<CategoryProvider>(context).getcategory();

      if (rest != null) {
        setState(() {
          _iscomplete = !_iscomplete;
          print("loading finished");
          _isloaded = true;
        });

        print("restuarant");
        for (int i = 0; i < 6; i++) {
          print(rest![0].tableMenuList![i].menuCategory);
        }

        print("lenght");
        print(rest![0].tableMenuList!.length);
      }
    }

    setState(() {
      _isinit = false;
    });
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // user!=null?user:null;
    print("username");
    print(user?.displayName);

    final catprovider = Provider.of<CategoryProvider>(context, listen: false);

    final cat = catprovider.category;

    List<Widget> children;
    int l = 0;

    //if(cat.isNotEmpty)
    if (_iscomplete == true) {
      print("inside widget");
      print(l);
      if (rest![0] != null) {
        l = rest![0].tableMenuList!.length;
      } else {
        l = 0;
      }
    }

    //  l=rest![0].tableMenuList!.length??0;
    if (_isloaded == true) {
      children = rest![0] != null
          ? List.generate(
              l,
              (index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        rest![0].tableMenuList![index].menuCategory.toString()),
                  ))
          : [Text('loading..')];
    } else {
      children = [Text('loading...')];
    }

    List<Widget> data;

    //if(cat.isNotEmpty)

    if (_isloaded == true) {
      data = List.generate(
          l,
          (index) =>

              FoodCard(
                catdishes: rest![0].tableMenuList![index].categoryDishes,
                quantity: 0,
              ));
    } else {
      data = [Text('loading..')];
    }

    final cartprovider = Provider.of<CartProvider>(context, listen: true);

    var cart = cartprovider.cart;

    int cartlength = cartprovider.itemcount;

  //  print("cart : ");
   // int len = cart!.length;
    int i = 0;

    /* while(i<len){

      print(cart[i].id);
      print(cart[i].quantity);
      i=i+1;
    }

    */

    return DefaultTabController(
      length: children.length,
      child: Scaffold(
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                              radius: 40.0,
                              backgroundImage: user != null
                                  ? NetworkImage(user.photoURL.toString())
                                  : const NetworkImage(
                                      'https://imgv3.fotor.com/images/homepage-feature-card/Fotor-AI-photo-enhancement-tool.jpg) // for Network image')),
                        const  SizedBox(
                            height: 10.0,
                          ),
                          user != null
                              ?  Text(
                                  user.displayName.toString(),
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'xyz',
                                  style: TextStyle(color: Colors.black),
                                ),
                        ],
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius:  BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                  ),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.signOut),
                  title: Text('Log Out'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer

                    FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => SignIn())));
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),

            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            // title:  user!=null?Text('Welcome '+user.displayName.toString(),style: TextStyle(color: Colors.black),):Text('Good morning',style: TextStyle(color: Colors.black),),

            //children is the tabs
            bottom: TabBar(
              labelColor: Colors.red,
              indicatorColor: Colors.red,
              unselectedLabelColor: Colors.black,

              isScrollable: true,
              tabs: children,
            ),

            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: Container(

                  child: Badge(

                    position: BadgePosition.topEnd(top: 3, end: 3),
                    animationDuration: Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      cartlength.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                        },
                        child: IconButton(
                            icon: Icon(Icons.shopping_cart), onPressed: () {})),
                  ),
                ),
              )
            ],
          ),
          body: _isloaded
              ? LayoutBuilder(
                  builder: (context, constraints) => TabBarView(children: data))
              : Center(child: CircularProgressIndicator())),
    );
    Container(
        height: 20.0,
        width: 20.0,
        color: Colors.black,
        child: CircularProgressIndicator());
  }
}

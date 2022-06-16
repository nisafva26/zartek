import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek/providers/CartProvider.dart';
import 'package:zartek/providers/CategoryProvider.dart';
import 'package:zartek/providers/SignInProvider.dart';
import 'package:zartek/screens/HomePage.dart';
import 'package:zartek/screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => SignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,


        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx,usersnapshot){
            if(usersnapshot.hasData)
              return HomePage(); //ChatScreen();
            return SignIn();
          } ,
        ),
      ),
    );
  }
}




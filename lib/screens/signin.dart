

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek/providers/SignInProvider.dart';
import 'package:zartek/screens/phoneauth.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool _isphone=false;
  bool _isgoogle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(



        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(


                onTap: (){

                  setState(() {
                    _isgoogle=true;
                  });

                  final provier = Provider.of<SignInProvider>(context,listen: false);
                  provier.signup(context);


                },
                child: Center(

                  child: Container(

                    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width/1.5,
                    decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    child: _isgoogle==false?Row(

                      children: [
                        FaIcon(FontAwesomeIcons.google,color: Colors.white,),
                        SizedBox(width: 50.0,),
                        Text('Google',style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700),)
                      ],
                    ):Center(child: CircularProgressIndicator(color: Colors.white,))
                  ),
                )

              ),
              SizedBox(height: 20.0,),
              GestureDetector(


                  onTap: (){


                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                  },
                  child: Center(

                    child: Container(

                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                          color: Colors.green[800],
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: Row(

                        children: [
                          FaIcon(FontAwesomeIcons.phone,color: Colors.white,),
                          SizedBox(width: 50.0,),
                          Text('Phone',style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700),)
                        ],
                      ),
                    ),
                  )

              ),
            ],
          )

        ),
      ),
    );
  }
}


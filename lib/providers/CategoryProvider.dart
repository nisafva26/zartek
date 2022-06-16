import 'package:flutter/material.dart';
import 'package:zartek/class/CategoryClass.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:zartek/class/ResturantClass.dart';

class CategoryProvider extends ChangeNotifier{

  List<Category> _category = [
   /*       Category(catname: 'Salads and soup',catid: 11),
    Category(catname: 'newcat',catid: 12),
    Category(catname: 'newcat3',catid: 13),
    Category(catname: 'newcat3',catid: 13),

    */
  ];


   List<Category> get category {

     return [..._category];
   }

  Future<List<Restuarant>?> getcategory() async {
    final url = Uri.parse(
        'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');

      final response = await http.get(url);
      print(response);
      if(response.statusCode==200){
        print("inside api");
        print(response.body);
        var json=response.body;
        return restuarantFromJson(json);

      }
      else{
        print("cannot go to the api");
      }


  }



}
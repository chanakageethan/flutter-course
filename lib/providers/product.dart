import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  late bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});


  void _setFavValue(bool newValue){
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async{
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://flutter-course-f54c8-default-rtdb.firebaseio.com/product/${id}.json';


    try {
     final response = await http.patch(Uri.parse(url),
          body: json.encode({
            'isFavorite': isFavorite,
          }));

     if(response.statusCode >= 400){
       _setFavValue(oldStatus);
     }

    }catch(e){
      _setFavValue(oldStatus);
    }
  }
}

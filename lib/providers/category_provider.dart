import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  String _category = 'Recent';

  
 


  String get category => _category;

  void setCategory(String category) {
    _category = category;
    notifyListeners();
  }
}

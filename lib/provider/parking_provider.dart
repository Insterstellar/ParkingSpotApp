import 'package:flutter/cupertino.dart';

class DistancePriceProvider extends ChangeNotifier {

  int count = 0;
  double _distance = 50;
  double _price  =300;

  double get distance =>_distance;
  double get price =>_price;
 // int get count => _count;


  void getDistance (double distance){
    _distance=distance;
    notifyListeners();
  }

  void getPrice (double price){
    _price=price;
    notifyListeners();
  }

  void increment (){
    count++;
    notifyListeners();
  }


  void dincrement (){
    count--;
    notifyListeners();
  }
}
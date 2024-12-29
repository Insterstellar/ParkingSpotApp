import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:parking/models/user_parking.dart';

class ShowDirectionProvider extends ChangeNotifier{


  UserParking? _userParking;
  UserParking   get userParking => _userParking!;

  //ShowDirectionsProvider( this._userParking);

  void getUserDetailsProvider (UserParking userParking) {
    _userParking = userParking;
    notifyListeners();
  }
}
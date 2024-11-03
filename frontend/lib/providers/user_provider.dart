import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User(userId: 'defaultID', userName: 'defaultName');

  User get user => _user;

  void setUser(User newUser) {
    if (_user != newUser) {
      _user = newUser;
      notifyListeners();
    }
  }
}

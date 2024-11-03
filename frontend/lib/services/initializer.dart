import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class Initializer {
  static void initialize(BuildContext context) {
    _loadUserData(context);

  }

  static void _loadUserData(BuildContext context) {
    // api call
    var fetchedUser = User(userId: "1", userName: "john");
    Provider.of<UserProvider>(context, listen: false).setUser(fetchedUser);
  }
}

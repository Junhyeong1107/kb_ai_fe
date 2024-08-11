import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userid;

  String? get userid => _userid;

  void setUserId(String userid) {
    _userid = userid;
    notifyListeners();
  }

  void clearUser() {
    _userid = null;
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

class LoginViewProvider extends ChangeNotifier {
  String emailPhone;
  String password;
  bool obscureText = true;
  bool btnEnabled = false;

  void obscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void enabled() {
    if (emailPhone.length > 4 && password.length > 5)
      btnEnabled = true;
    else
      btnEnabled = false;
    notifyListeners();
  }
}

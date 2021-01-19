import 'package:flutter/foundation.dart';
import 'package:regexpattern/regexpattern.dart';

class LoginViewProvider extends ChangeNotifier {
  String emailPhone;
  String password;
  bool obscureText = true;
  bool btnEnabled = false;

  void obscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void setBtnStatus() {
    if (emailPhone != null &&
        emailPhone != '' &&
        password != null &&
        password != '')
      btnEnabled = true;
    else
      btnEnabled = false;
    notifyListeners();
  }
}

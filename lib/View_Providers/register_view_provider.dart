import 'package:flutter/foundation.dart';

class RegisterViewProvider extends ChangeNotifier {
  String name;
  String email;
  String phone;
  String pass;
  String repeatPass;
  bool obscurePass = true;
  bool obscureRepeatPass = true;
  bool btnEnabled = false;

  set setName(String name) {
    this.name = name;
    notifyListeners();
  }

  set setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  set setPhone(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  set setPass(String pass) {
    this.pass = pass;
    notifyListeners();
  }

  set setRepeatPass(String repeatPass) {
    this.repeatPass = repeatPass;
    notifyListeners();
  }

  void setObscure(String field) {
    if (field == 'pass') obscurePass = !obscurePass;
    if (field == 'repeatPass') obscureRepeatPass = !obscureRepeatPass;
    notifyListeners();
  }

  void setBtnStatus() {
    if (name.length < 1 ||
        !email.contains(RegExp(r'@[a-zA-Z]+\.[a-zA-Z]+')) ||
        phone.length < 1 ||
        pass.length < 6 ||
        repeatPass != pass)
      btnEnabled = false;
    else
      btnEnabled = true;
    notifyListeners();
  }

  void enabled() {
    if (name.length < 1 ||
        !email.contains(RegExp(r'@[a-zA-Z]+\.[a-zA-Z]+')) ||
        phone.length < 1 ||
        pass.length < 6 ||
        repeatPass != pass)
      btnEnabled = false;
    else
      btnEnabled = true;
    notifyListeners();
  }
}

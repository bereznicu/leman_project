import 'package:flutter/foundation.dart';

class RegisterViewProvider extends ChangeNotifier {
  String name;
  String email;
  String phone;
  Map<String, dynamic> passField = {'value': '', 'obscureText': true};
  Map<String, dynamic> repeatPassField = {'value': '', 'obscureText': true};
  bool obscureText = true;
  bool obscureText2 = true;
  bool btnEnabled = false;

  String nameError;
  String emailError;
  String phoneError;
  String passwordError;
  String repeatPasswordError;

  void obscure(int obscureNr) {
    if (obscureNr == 1) obscureText = !obscureText;
    if (obscureNr == 2) obscureText2 = !obscureText2;
    notifyListeners();
  }

  void enabled() {
    if (name.length < 1 ||
        !email.contains(RegExp(r'@[a-zA-Z]+\.[a-zA-Z]+')) ||
        phone.length < 1 ||
        password.length < 6 ||
        repeatPassword != password)
      btnEnabled = false;
    else
      btnEnabled = true;
    notifyListeners();
  }
}

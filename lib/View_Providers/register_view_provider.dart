import 'package:flutter/foundation.dart';
import 'package:regexpattern/regexpattern.dart';

class RegisterViewProvider extends ChangeNotifier {
  String name;
  String email;
  String phone;
  String pass = "";
  String repeatPass = "";
  bool obscurePass = true;
  bool obscureRepeatPass = true;
  bool btnEnabled = false;
  String emailError;
  String nameError;
  String phoneError;
  String passError;
  String repeatPassError;

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

  void setEmailError() {
    if (email.isEmail())
      emailError = null;
    else
      emailError = "Introduceți o adresă de e-mail validă";
    notifyListeners();
  }

  void setNameError() {
    if (name.contains(RegExp(r'[A-Z].* [A-Z].*')))
      nameError = null;
    else
      nameError = "Format invalid (ex. valid: Nume Prenume)";
    notifyListeners();
  }

  void setPhoneError() {
    if (phone == '' || phone == null)
      phoneError = null;
    else {
      if (phone.isPhone())
        phoneError = null;
      else
        phoneError = "Introduceți un număr de telefon valid";
    }
  }

  void setPassError() {
    if (pass.isPasswordHard())
      passError = null;
    else
      passError =
          "Parola trebuie să conțină cel puțin: 8 caractere, o majusculă, o minusculă, o cifră și un caracter special(\$,@,*,...)";
  }

  void setRepeatPassError() {
    if (repeatPass == pass)
      repeatPassError = null;
    else
      repeatPassError = "Parolele nu se potrivesc";
  }

  void setBtnStatus() {
    if (nameError != null ||
        emailError != null ||
        passError != null ||
        repeatPassError != null)
      btnEnabled = false;
    else
      btnEnabled = true;
    notifyListeners();
  }
}

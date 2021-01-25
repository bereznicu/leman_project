import 'package:flutter/foundation.dart';

class AddEmployeeProvider extends ChangeNotifier {
  String name;
  String nameError;
  bool btnEnabled = false;

  set setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setNameError() {
    if (name.contains(RegExp(r'[A-Z].* [A-Z].*')))
      nameError = null;
    else
      nameError = "Format invalid (ex. valid: Nume Prenume)";
    notifyListeners();
  }

  void setBtnStatus() {
    if (nameError != null)
      btnEnabled = false;
    else
      btnEnabled = true;
    notifyListeners();
  }
}

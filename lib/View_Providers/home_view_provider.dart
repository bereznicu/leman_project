import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/Common/constants.dart';
import 'package:leman_project/Entities/employee_entity.dart';
import 'package:leman_project/Services/auth_service.dart';

class HomeViewProvider extends ChangeNotifier {
  String searchString;
  bool focus = false;
  String selectedSort = '';
  List<EmployeeEntity> employeesList = [EmployeeEntity(name: "Se încarcă")];
  List<EmployeeEntity> filteredList = [EmployeeEntity(name: "Se încarcă")];
  AuthService authService = new AuthService();

  void initList(List<EmployeeEntity> newList) {
    employeesList = newList;
    searchedString(searchString);
  }

  void searchedString(String value) {
    searchString = value;
    if (value == '' || value == null) {
      filteredList = employeesList;
    } else {
      filteredList = employeesList
          .where((employee) =>
              employee.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    filteredList = sort(filteredList);
    notifyListeners();
  }

  void sortList(String choice) {
    if (choice == Constants.az)
      selectedSort = Constants.az;
    else
      selectedSort = Constants.za;
    filteredList = sort(filteredList);
    notifyListeners();
  }

  void settingsMenuActions(String choice) {
    if (choice == Constants.deconectare) authService.logout();
  }

  void changeSearchBarFocus(bool value, context) {
    focus = value;
    if (focus == false) FocusScope.of(context).requestFocus(new FocusNode());
    notifyListeners();
  }

  List<EmployeeEntity> sort(List<EmployeeEntity> list) {
    if (Constants.az == selectedSort)
      list.sort((a, b) => (a.name).compareTo(b.name));
    if (Constants.za == selectedSort)
      list.sort((b, a) => (a.name).compareTo(b.name));
    return list;
  }
}

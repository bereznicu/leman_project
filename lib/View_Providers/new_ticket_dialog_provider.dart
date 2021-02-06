import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class NewTicketProvider extends ChangeNotifier {
  List<String> dropDownChoices = [
    "Absență",
    "Reclamații interne",
    "Reclamații externe"
  ];
  String selectedCategory = "Absență";
  // DateTime initialDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String details;

  void updateSelectedCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  void updateDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:leman_project/Entities/ticket_entity.dart';

class EmployeeViewProvider extends ChangeNotifier {
  String date =
      DateFormat('yMMM').format(DateTime.now()); //folosit pentru afisaj
  DateTime selectedDate = DateTime.now(); //folosit pentru query-uri
  List<TicketEntity> tickets = new List<TicketEntity>();

  void previousMonth() {
    selectedDate = Jiffy(selectedDate).subtract(months: 1);
    date = DateFormat('yMMM').format(selectedDate);
    notifyListeners();
  }

  void nextMonth() {
    selectedDate = Jiffy(selectedDate).add(months: 1);
    date = DateFormat('yMMM').format(selectedDate);
    notifyListeners();
  }

  void updateDate(DateTime value) {
    selectedDate = value;
    date = DateFormat('yMMM').format(selectedDate);
    notifyListeners();
  }

  void initList(List<TicketEntity> list) {
    tickets = list;
    notifyListeners();
  }
}

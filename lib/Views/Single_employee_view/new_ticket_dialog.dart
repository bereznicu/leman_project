import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/Entities/employee_entity.dart';
import 'package:leman_project/Entities/ticket_entity.dart';
import 'package:leman_project/Services/employees_service.dart';
import 'package:leman_project/View_Providers/new_ticket_dialog_provider.dart';
import 'package:provider/provider.dart';

class NewTicketDialog extends StatefulWidget {
  const NewTicketDialog({Key key, @required this.employee}) : super(key: key);
  final EmployeeEntity employee;
  @override
  _NewTicketDialogState createState() => _NewTicketDialogState();
}

class _NewTicketDialogState extends State<NewTicketDialog> {
  @override
  Widget build(BuildContext context) {
    final dialogProvider =
        Provider.of<NewTicketProvider>(context, listen: false);
    final employeesService =
        Provider.of<EmployeesService>(context, listen: false);
    return AlertDialog(
      scrollable: true,
      title: Text("Creare tichet nou"),
      content: Column(children: <Widget>[
        spacer(height(context) * 0.05, 0.0),
        Text(
          "Selectați tipul tichetului:",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Selector<NewTicketProvider, String>(
          selector: (_, dialogProvider) => dialogProvider.selectedCategory,
          builder: (_, selectedCategory, child) {
            return DropdownButton<String>(
              style: TextStyle(fontSize: 17.0, color: Colors.black),
              dropdownColor: Colors.grey[100],
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.cyan[700],
              ),
              value: selectedCategory,
              onChanged: (String newValue) {
                dialogProvider.updateSelectedCategory(newValue);
              },
              items: dialogProvider.dropDownChoices
                  .map<DropdownMenuItem<String>>((String choice) {
                return DropdownMenuItem<String>(
                  child: Text(choice),
                  value: choice,
                );
              }).toList(),
            );
          },
        ),
        spacer(height(context) * 0.05, 0.0),
        Text(
          "Selectați data:",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        spacer(height(context) * 0.003, 0.0),
        Selector<NewTicketProvider, DateTime>(
            selector: (_, dialogProvider) => dialogProvider.selectedDate,
            builder: (_, selectedDate, child) {
              return ListTile(
                onTap: () async {
                  showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101),
                  ).then((DateTime value) {
                    if (value != null) dialogProvider.updateDate(value);
                  });
                },
                title: Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(
                      backgroundColor: Colors.grey[200], fontSize: 17.0),
                ),
                trailing: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.cyan[700],
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: orientation(context) == 'portrait'
                        ? width(context) * 0.1
                        : width(context) * 0.05),
              );
            }),
        spacer(height(context) * 0.04, 0),
        TextField(
          onChanged: (value) {
            dialogProvider.details = value;
          },
          maxLines: 3,
          decoration: InputDecoration(
            labelText: "Detalii suplimentare",
            border: OutlineInputBorder(),
          ),
        ),
      ]),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          label: Text(
            "Anulare",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.red[300],
          onPressed: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => AlertDialog(
                      content: Text("Anulați crearea tichetului?"),
                      actions: [
                        FlatButton.icon(
                          icon: Icon(Icons.check),
                          label: Text("Confirm"),
                          onPressed: () {
                            Navigator.pop(context, 'confirm');
                          },
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.cancel),
                          label: Text("Nu"),
                          onPressed: () {
                            Navigator.pop(context, 'no');
                          },
                        ),
                      ],
                    )).then((response) {
              if (response == 'confirm') Navigator.pop(context);
            });
          },
        ),
        FlatButton.icon(
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          label: Text(
            "Creare",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green[300],
          onPressed: () async {
            TicketEntity newTicket = new TicketEntity(
                category: dialogProvider.selectedCategory,
                date: dialogProvider.selectedDate,
                details: dialogProvider.details);
            employeesService
                .addTicket(widget.employee, newTicket)
                .then((response) {
              if (response == 'success' || response == 'offline')
                Navigator.pop(context, response);
              else
                return Flushbar(
                  message: response,
                  backgroundColor: Colors.red[300],
                  duration: Duration(seconds: 3),
                )..show(context);
            });
          },
        ),
      ],
    );
  }
}

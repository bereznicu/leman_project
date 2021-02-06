import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/Entities/employee_entity.dart';
import 'package:leman_project/View_Providers/new_ticket_dialog_provider.dart';
import 'package:leman_project/Views/Single_employee_view/new_ticket_dialog.dart';
import 'package:provider/provider.dart';

class EmployeeViewActionButton extends StatefulWidget {
  const EmployeeViewActionButton({Key key, @required this.employee})
      : super(key: key);
  final EmployeeEntity employee;
  @override
  _EmployeeViewActionButtonState createState() =>
      _EmployeeViewActionButtonState();
}

class _EmployeeViewActionButtonState extends State<EmployeeViewActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.cyan[700],
      child: Icon(Icons.add),
      onPressed: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => ChangeNotifierProvider<NewTicketProvider>(
                  create: (BuildContext context) => NewTicketProvider(),
                  child: NewTicketDialog(
                    employee: widget.employee,
                  ),
                )).then((response) {
          if (response == 'success')
            return Flushbar(
              message: 'Tichet adăugat cu succes',
              backgroundColor: Colors.green[300],
              duration: Duration(seconds: 3),
            )..show(context);
          if (response == 'offline')
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => AlertDialog(
                      scrollable: true,
                      title: Text("Offline"),
                      content: Text(
                          "Conexiune la internet nedectată. Tichetul va fi disponibil in baza de date de în dată ce se reia conexiunea."),
                      actions: <Widget>[
                        FlatButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.check),
                          label: Text("Ok"),
                          color: Colors.cyan[700],
                        )
                      ],
                    ));
        });
      },
    );
  }
}

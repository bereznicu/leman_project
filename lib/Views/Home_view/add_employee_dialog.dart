import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/Services/employees_service.dart';
import 'package:leman_project/View_Providers/add_employee_dialog_provider.dart';
import 'package:leman_project/Views/Home_view/dismiss_employee_adder_dialog.dart';
import 'package:provider/provider.dart';

class AddEmployeeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addEmployeeProvider =
        Provider.of<AddEmployeeProvider>(context, listen: false);
    final employeesService =
        Provider.of<EmployeesService>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return showDialog(
            context: context,
            builder: (context) {
              return DismissEmployeeAdderDialog();
            }).then((value) {
          if (value == "dismissed") Navigator.pop(context);
        });
      },
      child: AlertDialog(
        actions: [
          //Cancel action
          FlatButton.icon(
            color: Colors.red[300],
            icon: Icon(Icons.cancel),
            label: Text("Anulare"),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DismissEmployeeAdderDialog();
                  }).then((value) {
                if (value == "dismissed") Navigator.pop(context);
              });
            },
          ),
          //Add employee action
          Selector<AddEmployeeProvider, bool>(
            selector: (context, employeeProvider) =>
                employeeProvider.btnEnabled,
            builder: (context, enabled, child) {
              return FlatButton.icon(
                onPressed: enabled == false
                    ? null
                    : () async {
                        employeesService
                            .addEmployee(addEmployeeProvider.name)
                            .then((value) {
                          if (value == 'success')
                            Navigator.pop(context, 'success');
                          if (value == 'offline')
                            Navigator.pop(context, 'offline');
                          else
                            return Flushbar(
                              message: value,
                              backgroundColor: Colors.red[300],
                              duration: Duration(seconds: 3),
                            )..show(context);
                        });
                      },
                disabledColor: Colors.grey,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text("Adaugă", style: TextStyle(color: Colors.white)),
                color: Colors.cyan[700],
              );
            },
          )
        ],
        scrollable: true,
        title: Text("Adăugare angajat"),
        content: Column(
          children: <Widget>[
            Selector<AddEmployeeProvider, String>(
              selector: (context, employeeProvider) =>
                  employeeProvider.nameError,
              builder: (context, nameError, child) {
                return TextFormField(
                  keyboardType: TextInputType.name,
                  onChanged: (String value) {
                    addEmployeeProvider.setName = value;
                    addEmployeeProvider.setNameError();
                    addEmployeeProvider.setBtnStatus();
                  },
                  decoration: InputDecoration(
                    errorText: nameError,
                    errorMaxLines: 2,
                    labelText: "Nume Prenume",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
